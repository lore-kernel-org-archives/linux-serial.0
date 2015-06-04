From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH linux-next 1/4] ARM: at91/dt: add new DT properties for
 Atmel usart
Date: Thu, 4 Jun 2015 14:34:57 +0200
Message-ID: <20150604143457.2a0e0acf@north>
References: <cover.1433253787.git.cyrille.pitchen@atmel.com>
	<6fe7914a2c39245ac9a05cdb9962b88c409ec1a4.1433253787.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6fe7914a2c39245ac9a05cdb9962b88c409ec1a4.1433253787.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, nicolas.ferre@atmel.com, gregkh@linuxfoundation.org, wenyou.yang@atmel.com, ludovic.desroches@atmel.com, leilei.zhao@atmel.com, josh.wu@atmel.com, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2 Jun 2015 16:18:21 +0200, Cyrille Pitchen wrote:
> +- atmel,rts-low-threshold: when the RX FIFO level, ie the number of data
> +  available to be read from the RX FIFO, crosses down this threshold the RTS
> +  line is driven to low level to tell the remote peer that it can (re)start
> +  sending new data.
> +- atmel,rts-high-threshold: when the RX FIFO level crosses up this threshold,
> +  the RTS line is driven to high level to tell the remote peer that it should
> +  stop sending new data.

Maintainers, are there any guidelines for what is appropriate to put
into DT?  The parameters above look like they could be programmed at
runtime through some user space API like sysfs.
