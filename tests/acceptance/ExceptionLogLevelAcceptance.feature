Feature: LogLevel

  Background:
    Given I have the following config
      """
      <?xml version="1.0"?>
      <psalm>
        <projectFiles><directory name="."/></projectFiles>
        <stubs>
            <file name="../../stubs-for-exception/LoggerInterface.phpstub" />
        </stubs>
      </psalm>
      """
    And I have the following code preamble
      """
      <?php
      use Psr\Log\LoggerInterface;

      /**
       * @psalm-suppress InvalidReturnType
       * @return LoggerInterface
       */
      function impl_interface() {}

      """

  Scenario: Passed invalid Log level
    Given I have the following code
      """
      impl_interface()->log("panic", "message");
      """
    When I run Psalm
    Then I see these errors
      | Type            | Message                                                                                                                      |
      | InvalidArgument | Argument 1 of Psr\Log\LoggerInterface::log expects 'alert'\|'critical'\|'debug'\|'emergency'\|'error'\|'info'\|'notice'\|'warning', but 'panic' provided |
    And I see no other errors