From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3] serial: imx: warn user when using unsupported
 configuration
Date: Thu, 19 Apr 2018 18:26:14 +0200
Message-ID: <20180419162614.erf33d4kwt2clnev@pengutronix.de>
References: <20180419153916.21898-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180419153916.21898-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Stefan,

On Thu, Apr 19, 2018 at 05:39:16PM +0200, Stefan Agner wrote:
> When using half-duplex mode (which disables receiver during txing)
> the RTS signal cannot be driven low during transmission when using
> i.MX UART RTS/CTS control. This seems to be a limitation of the
> i.MX UART IP: The RTS (CTS_B) signal is controlled by the receiver.
> When the receiver is disabled, the signal stays in UART logic idle
> state which is high...
> 
> If SER_RS485_RTS_ON_SEND is used, RTS needs to be high active during
> transmission. Since this is the default state of the RTS (CTS_B)
> signal when the receiver is off, half-duplex mode in this
> configuration works fine.
> 
> However, a low-active RTS signal (flag SER_RS485_RTS_ON_SEND not set)
> cannot be generated when the receiver is turned off.
> 
> Print an error if the user selects this unsupported configuration
> (both SER_RS485_RTS_ON_SEND and SER_RS485_RX_DURING_TX unset) and
> configure the closest working configuration (set the
> SER_RS485_RX_DURING_TX flag).
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
