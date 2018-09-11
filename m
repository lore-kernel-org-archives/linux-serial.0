From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Date: Tue, 11 Sep 2018 09:51:27 +0100
Message-ID: <20180911085127.GD4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
 <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd9104b702feec556ed01311e9efcb96790131d0.camel@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Nicolae Pirea <pirea.radu@gmail.com>
Cc: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, richard.genoud@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org, linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 11 Sep 2018, Radu Nicolae Pirea wrote:

> Hi Lee,
> 
> Thank you for taking the patch series, but you didn't take the latest
> version(v12) :)

Both were marked for merging in my inbox, and since I am working
though my (300+) post-vacation emails chronologically v11 was handled
first.

It appears as though there is an issue in the way 'struct
of_device_id' was declared too.  The header file in which it was
declared used to be included by proxy, however a separation has
recently been made causing build errors.

I will fix both issues and re-submit the PR.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
