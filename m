From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2] serial/arc-uart: Add new driver
Date: Wed, 3 Oct 2012 12:40:35 +0530
Message-ID: <506BE4EB.4010904@synopsys.com>
References: <1349154216-7906-1-git-send-email-vgupta@synopsys.com> <20121002124707.32b70292@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121002124707.32b70292@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tuesday 02 October 2012 05:17 PM, Alan Cox wrote:
>> +/* Is this for UART emulation on ARC Instruction Set Simulator (ISS)
>> */ +int __attribute__((weak)) running_on_iss;
> Why not pass a quirks field in your platform data instead - much
> cleaner than a global.

I'd thought about it too. However the platform data is retrieved in
arc_uart_init_one() while it's usage in arc_serial_set_termios() will be
in a different call chain, meaning this info will have to be anyways
saved in "some" data structure - probably within struct arc_uart_port -
and that too per port - which is not clean either. However if you
strongly feel that the global is a must go - I can rework it that way.

thx,
-Vineet
