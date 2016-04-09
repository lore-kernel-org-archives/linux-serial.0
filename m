From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v1 00/12] serial: 8250: split LPSS to 8250_lpss, enable
 DMA on Quark
Date: Sat, 09 Apr 2016 17:53:09 +0100
Message-ID: <1460220789.19152.5.camel@nexus-software.ie>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ismo.puustinen@intel.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2016-04-07 at 23:37 +0300, Andy Shevchenko wrote:
> This is combined series of two things:
>  - split out the Intel LPSS specific driver from 8250_pci into
> 8250_lpss
>  - enable DMA support on Intel Quark UART
> 
> The patch has been tested on few Intel SoCs / platforms.
> 
> This is targeting serial subsystem, thus it would be nice to get and
> Ack from Vinod first.
> Moreover, the series depends on series [1] that is now under review.
> 
> That's why I ask Vinod to create immutable tag / branch for the [1]
> and the
> dependants (at least one more, which is sata_dwc_460ex).
> 
> [1] http://www.spinics.net/lists/dmaengine/msg08709.html

Andy.

Which tree/branch exactly are you applying this against ? I'd like to
test it out on Galileo.

Could you give a link ?

---
bod
