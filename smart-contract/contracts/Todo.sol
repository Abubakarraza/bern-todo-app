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
}
