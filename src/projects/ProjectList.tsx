import React, { useState } from "react";

import { Project } from "./Project";
import ProjectCard from "./ProjectCard";
import ProjectForm from "./ProjectForm";

interface ProjectListProps {
  projects: Project[];
  onSave: (project: Project) => void;
}

function ProjectList({ projects, onSave }: ProjectListProps) {
  const cancelEditing = () => {
    setProjectBeingEdited({});
  };
  const [projectBeingEdited, setProjectBeingEdited] = useState({});
  const handleEdit = (project: Project) => {
    setProjectBeingEdited(project);
    // console.log(project)
  };
  const items = projects.map((project) => (
    <div key={project.id} className="cols-sm">
      {project === projectBeingEdited ? (
        <ProjectForm onSave={onSave} project={project} onCancel={cancelEditing} />
      ) : (
        <ProjectCard project={project} onEdit={handleEdit} />
      )}
    </div>
  ));
  return <div className="row">{items}</div>;
}

export default ProjectList;
