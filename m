From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v9 00/11] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Tue, 21 Jun 2016 16:10:05 +0100
Message-ID: <1466521805.520.266.camel@nexus-software.ie>
References: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466414282-96691-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 2016-06-20 at 12:17 +0300, Andy Shevchenko wrote:
> This is combined series of two things:
> - split out the Intel LPSS specific driver from 8250_pci into
> 8250_lpss
> - enable DMA support on Intel Quark UART
> 
> The patch has been tested on few Intel SoCs / platforms. In any case
> I would
> like to ask Bryan to do independent test.
> 
> This is targeting serial subsystem, and it has necessary Ack from
> Vinod.
> 
> The series can be reached in the branch located at [2].
> 
> [1] http://www.spinics.net/lists/kernel/msg2244475.html
> [2] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk
> 
> Bryan, since this series doesn't include any DMA management quirks I
> didn't
> address it. It is a matter of the following series which I would send
> later.

OK I'm not 100% happy with that but I trust you to do it.

For the series.

Reviewed-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Tested-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
