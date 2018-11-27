From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: DMA: atmel_serial: Opening and closing the serial device
 repeatedly causes kmalloc-32 slab leak
Date: Tue, 27 Nov 2018 10:58:43 +0100
Message-ID: <20181127095843.GF19871@piout.net>
References: <22061488.b0eNpyQjWt@linux-7rm0>
 <83753d21-f3c8-c8dd-75d7-741cb597d1a3@sorico.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <83753d21-f3c8-c8dd-75d7-741cb597d1a3@sorico.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: richard.genoud@gmail.com
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Vinod Koul <vinod.koul@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dmaengine@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Mario Forner <m.forner@be4energy.com>
List-Id: linux-serial@vger.kernel.org

Hello Richard,

On 27/11/2018 10:51:13+0100, richard.genoud@gmail.com wrote:
> Hi all,
> 
> I reproduced the memory leak on my board (at91sam9g35-cm) with a 4.20-rc3.
> 
> It triggered an OOM after a couple of hours running a code like this:
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> 
> 
> int main(int argc, char **argv)
> {
> 	int fd;
> 	do {
> 		fd = open("/dev/ttyS1", O_RDONLY);
> 		close(fd);
> 	} while (true);
> 	return 0;
> }
> 
> As Mario pointed out, this only happens when atmel,use-dma-{r,t}x are
> used in the device-tree.
> 
> Adding:
> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_SLAB_LEAK=y
> Doesn't show anything suspect in /proc/slab_allocators
> 
> From what I found until now, it's something done in :
> dma_request_slave_channel();
> that leaks kmalloc-32
> Mabe I missed something, but it seems that everything DMA related is
> deallocated in atmel_release_{tx,rx}_dma().
> 
> Is this ringing a bell ?
> 

Yes, this is known issue and it has yet to be worked on.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
