// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Todo {
    struct Task {
        uint256 id;
        string name;
        string date;
    }
    address owner;
    Task task;
    mapping(uint256 => Task) tasks;
    uint256 taskId = 1;
    modifier checkId(uint256 id) {
        require(taskId > id && id != 0, "Invalid Id");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createTask(string calldata _taskName, string calldata _taskDate)
        public
    {
        tasks[taskId] = Task(taskId, _taskName, _taskDate);
        taskId++;
    }

    function updateTask(
        uint256 _taskId,
        string calldata _taskName,
        string calldata _taskDate
    ) public {
        tasks[_taskId] = Task(_taskId, _taskName, _taskDate);
    }

    function allTask() public view returns (Task[] memory) {
        Task[] memory taskList = new Task[](taskId - 1);
        for (uint256 i = 0; i < taskId - 1; i++) {
            taskList[i] = tasks[i + 1];
        }
        return taskList;
    }

    function viewTask(uint256 _taskId)
        public
        view
        checkId(_taskId)
        returns (Task memory)
    {
        return tasks[_taskId];
    }

    function deleteTask(uint256 _taskId) public checkId(_taskId) {
        delete tasks[_taskId];
    }
}
