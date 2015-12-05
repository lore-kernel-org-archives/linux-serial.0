From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH LINUX v3 04/10] tty: xuartps: Clear interrupt status
 register in shutdown
Date: Sat, 5 Dec 2015 09:25:53 -0800
Message-ID: <CAAtXAHdc5M=NVY-NMX1yWbObd3_fOjX8=TMdHs-hvjxBEzu3zw@mail.gmail.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
	<1448161172-19717-5-git-send-email-soren.brinkmann@xilinx.com>
	<56631CA0.5090707@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56631CA0.5090707@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Dec 5, 2015 at 9:19 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
>> When shutting down the UART, clear the interrupt status register.
>
> This changelog could have expanded on the way the interrupt status
> register worked so I didn't have to look this up myself.
>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
