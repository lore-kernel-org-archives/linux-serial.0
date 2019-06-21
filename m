From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 0/5] *** DMA based UART driver for AST2500 ***
Date: Fri, 21 Jun 2019 15:17:29 +0200
Message-ID: <20190621131729.GA9997@kroah.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "sudheer.v" <open.sudheer@gmail.com>
Cc: jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com, shivahshankar.shankarnarayanrao@aspeedtech.com, shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com, sudheer veliseti <sudheer.open@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 21, 2019 at 04:47:30PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> Hi,
> AST2500 has dedicated Uart DMA controller which has 12 sets of
> Tx and RX channels connected to UART controller directly.
> Since the DMA controller have dedicated buffers and registers,
> there would be little benifit in adding DMA framework overhead.
> So the software for DMA controller is included within the UART driver itself.
> 
> Thanks and Regards
> Sudheer.V

Is this a v2 of this patch series?

You always have to version your patches and say what changed from the
previous one, like the documentation says to do.

Please fix this up and resend.

thanks,

greg k-h
