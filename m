From: Colin Ian King <colin.king@canonical.com>
Subject: bug report: serial: 8250: Rate limit serial port rx interrupts during
 input overruns
Date: Sat, 22 Dec 2018 16:43:38 +0000
Message-ID: <5e1c661d-61ea-b639-46fe-f37326fe2e7e@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

Static analysis with CoverityScan found a potential null pointer
deference issue with a null uart with recent commit
6d7f677a2afa1c82d7fc7af7f9159cbffd5dc010 ("serial: 8250: Rate limit
serial port rx interrupts during input overruns").

Coverity Analysis is below:


 983        uart = serial8250_find_match_or_unused(&up->port);

    2. Condition uart, taking false branch.
    3. var_compare_op: Comparing uart to null implies that uart might be
null.

 984        if (uart && uart->port.type != PORT_8250_CIR) {
 985                if (uart->port.dev)

...
...

1075        /* Initialise interrupt backoff work if required */

    4. Condition up->overrun_backoff_time_ms > 0, taking false branch.

1076        if (up->overrun_backoff_time_ms > 0) {

    CID 1475967 (#1 of 2): Dereference after null check (FORWARD_NULL)

1077                uart->overrun_backoff_time_ms =
up->overrun_backoff_time_ms;
1078                INIT_DELAYED_WORK(&uart->overrun_backoff,
1079                                  serial_8250_overrun_backoff_work);
1080        } else {

    CID 1475967 (#2 of 2): Dereference after null check (FORWARD_NULL)5.
var_deref_op: Dereferencing null pointer uart.

1081                uart->overrun_backoff_time_ms = 0;
1082        }

The implication is that uart could be null, so the code block between
lines 1076 and 1082 should be guarded with a sanity null check on uart too.

Colin
