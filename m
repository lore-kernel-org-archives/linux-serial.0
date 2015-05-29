From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control
 from set/get_mctrl
Date: Fri, 29 May 2015 12:04:21 +0200
Message-ID: <20150529120421.754fd6ab@north>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
	<1432886754-30115-3-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432886754-30115-3-git-send-email-bhuvanchandra.dv@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, stefan@agner.ch, shawn.guo@linaro.org, kernel@pengutronix.de, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, bhuvanchandra.dv@gmail.com
List-Id: linux-serial@vger.kernel.org

On Fri, 29 May 2015 13:35:53 +0530, Bhuvanchandra DV wrote:
> The LPUART does not provide manual control of RTS/CTS signals,
> those can only be controlled by the hardware directly. Therefore
> manual control of those signals through mctrl can not be provided.
> The current implementation enables/disables the automatic control,
> which is not what mctrl should do, hence remove the incorrect
> implementation.
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>

Now that the functions do nothing there is probably no point in keeping
separate lpuart/lpuart32 variants.
