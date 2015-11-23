From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATH RESEND v2 03/10] tty: xuartps: Always enable transmitter in
 start_tx
Date: Mon, 23 Nov 2015 15:00:20 -0500
Message-ID: <56537054.6090208@hurleysoftware.com>
References: <1447963344-16266-1-git-send-email-soren.brinkmann@xilinx.com>
 <1447963344-16266-4-git-send-email-soren.brinkmann@xilinx.com>
 <564F0E75.5020100@hurleysoftware.com>
 <20151120152849.GU32017@xsjsorenbubuntu>
 <564F4A95.3010303@hurleysoftware.com>
 <20151120165804.GV32017@xsjsorenbubuntu>
 <564F5574.4070407@hurleysoftware.com> <5652BAD2.4090000@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5652BAD2.4090000@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Michal,

On 11/23/2015 02:05 AM, Michal Simek wrote:
> All these tests looks very interesting. Do you have any any
> work-in-progress repo with other tests? It will be good to run all of
> them to validate our drivers.

I haven't upstreamed these yet, but I plan to do so soon, along with
tty core, pty, n_tty i/o, termios, and torture tests and some basic tools.

Regards,
Peter Hurley
