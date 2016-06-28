package com.wipro.ats.bdre.wgen;

import com.wipro.ats.bdre.exception.BDREException;
import com.wipro.ats.bdre.md.api.GetProcess;
import com.wipro.ats.bdre.md.api.GetProperties;
import com.wipro.ats.bdre.md.beans.ProcessInfo;
import org.apache.log4j.Logger;

import java.util.Enumeration;
import java.util.List;

/**
 * Created by SU324335 on 5/5/2016.
 */
public class TeradataQueryActionNode extends GenericActionNode  {

    private static final Logger LOGGER = Logger.getLogger(TeradataQueryActionNode.class);
    private ProcessInfo processInfo = new ProcessInfo();
    private ActionNode actionNode = null;
    private OozieNode toNode;
    public OozieNode getToNode() {
        return toNode;
    }
    public void setToNode(OozieNode toNode) {
        this.toNode = toNode;
    }
    private OozieNode termNode;
    public OozieNode getTermNode() {
        return termNode;
    }
    public void setTermNode(OozieNode termNode) {
        this.termNode = termNode;
    }

    /**
     * This constructor is used to set node id and process information.
     *
     * @param actionNode An instance of ActionNode class which a workflow triggers the execution of a task.
     */
    public TeradataQueryActionNode(ActionNode actionNode) {
        setId(actionNode.getId());
        processInfo = actionNode.getProcessInfo();
        this.actionNode = actionNode;
    }

    public ProcessInfo getProcessInfo() {
        return processInfo;
    }


    public String getName() {

        String nodeName = "TeradataQuery-" + getId() + "-" + processInfo.getProcessName().replace(' ', '_');
        return nodeName.substring(0, Math.min(nodeName.length(), 45));

    }

    @Override
    public String getXML() {
        if (this.getProcessInfo().getParentProcessId() == 0) {
            return "";
        }
        StringBuilder ret = new StringBuilder();
        ret.append("\n<action name=\"" + getName() + "\">\n" +
                "        <shell xmlns=\"uri:oozie:shell-action:0.1\">\n" +
                "            <job-tracker>${jobTracker}</job-tracker>\n" +
                "            <name-node>${nameNode}</name-node>\n");
        ret.append("            <exec>query-runner-remote.sh</exec>\n");
        ret.append("            <argument>"+"tdquery/"+getProcessInfo().getBusDomainId()+"/"+getParentProcessTypeId()+"/"+getProcessInfo().getParentProcessId()+"/"+getTeradataQueryFile(getId(), "query-file").replace("tdquery/","")+"</argument>\n");
        ret.append("            <file>query-runner-remote.sh</file>\n");
        ret.append("            <file>" +getTeradataQueryFile(getId(), "query-file")+"</file>\n");
        ret.append("        </shell>\n" +
                "        <ok to=\"" + getToNode().getName() + "\"/>\n" +
                "        <error to=\"" + getTermNode().getName() + "\"/>\n" +
                "    </action>");

        return ret.toString();
    }

    /**
     * This method gets the required arguments for running the Teradata Query Script
     *
     * @param configGroup config_group entry in properties table for arguments
     * @return String containing arguments to be appended to workflow string.
     */
    public String getArguments(String configGroup) {
        GetProperties getProperties = new GetProperties();
        java.util.Properties argumentProperty = getProperties.getProperties(getId().toString(), configGroup);

        String arguments="";
        if(!argumentProperty.isEmpty()) {

            arguments = "            <argument>" + argumentProperty.values().toString().substring(1, argumentProperty.values().toString().length() - 1) + "</argument>\n";
        }
        return arguments;
    }

    /**
     * This method gets the required R Script file for running the TeradataQuery Script
     *
     * @param pid         process-id of R Script
     * @param configGroup config_group entry in properties table "rScript" for arguments
     * @return String containing arguments to be appended to workflow string.
     */
    public String getTeradataQueryFile(Integer pid, String configGroup) {
        GetProperties getProperties = new GetProperties();
        java.util.Properties tdQueryScript = getProperties.getProperties(getId().toString(), configGroup);
        Enumeration e = tdQueryScript.propertyNames();
        LOGGER.info("Script = " + tdQueryScript.size());
        StringBuilder addTdQueryPath = new StringBuilder();
        if (tdQueryScript.size() > 1) {
            throw new BDREException("Can Handle only 1 input file in TeradataQuery action, process type=" + processInfo.getProcessTypeId());
        } else {
            while (e.hasMoreElements()) {
                String key = (String) e.nextElement();
                addTdQueryPath.append(tdQueryScript.getProperty(key));
            }
        }

        return addTdQueryPath.toString();
    }


    public int getParentProcessTypeId(){
        Integer parentProcessId= this.getProcessInfo().getParentProcessId();
        GetProcess getProcess = new GetProcess();
        String[] params={"-p",parentProcessId.toString(),"-u","admin"};
        List<ProcessInfo> processInfoList = getProcess.execute(params);
        return processInfoList.get(0).getProcessTypeId();

    }
}
