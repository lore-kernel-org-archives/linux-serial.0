From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: of-serial: zero-out struct of_serial_info
Date: Thu, 30 Oct 2014 22:55 +0100
Message-ID: <5481851.EJfv4DSzbT@wuerfel>
References: <1414703913-1343-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414703913-1343-1-git-send-email-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jslaby@suse.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, jingchang.lu@freescale.com, gregory.0xf0@gmail.com
List-Id: linux-serial@vger.kernel.org

On Thursday 30 October 2014 14:18:33 Florian Fainelli wrote:
> of_platform_serial_probe() invokes of_platform_serial_setup() with a
> kmalloc'd struct of_serial_info cookie, which is not much of a problem
> for most of the struct of_serial_info fields we access but info->clk.
> 
> On platforms which do not provide a clock phandle for their UART nodes
> but do provide a 'clock-frequency' property, we basically leave the
> info->clk variable uninitialized, and this craps out during
> suspend/resume with oopses, crashes or warnings in the clock code.
> 
> Fix this by using kzalloc() which also zeroes-out the structure and
> provides an initialized info->clk member set to NULL.
> 
> Fixes: 2dea53bf57783 ("serial: of-serial: add PM suspend/resume support")
> Fixes: e34b9c94b6e8d ("[POWERPC] of_serial: add port type checking")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 

I thought I'd acked this patch before, maybe someone else sent the same
one. This is definitely required, so

Acked-by: Arnd Bergmann <arnd@arndb.de>
