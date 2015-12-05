From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH LINUX v3 05/10] tty: xuartps: Improve startup function
Date: Sat, 5 Dec 2015 12:21:34 -0500
Message-ID: <56631D1E.8050406@hurleysoftware.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
 <1448161172-19717-6-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448161172-19717-6-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> The startup function is supposed to initialize the UART for receiving.
> Hence, don't enable the TX part. Also, protect HW accesses with the port
> lock.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

NB: the request_irq() should be _after_ h/w programming, otherwise an
interrupt could be triggered and in-progress before the h/w has been
setup.
