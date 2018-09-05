From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V2 2/2] tty: serial: imx: add pinctrl sleep/default mode
 switch for suspend
Date: Wed, 5 Sep 2018 07:55:11 +0200
Message-ID: <20180905055511.ba46b2onz7skb7ln@pengutronix.de>
References: <1536110667-23530-1-git-send-email-Anson.Huang@nxp.com>
 <1536110667-23530-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536110667-23530-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 05, 2018 at 09:24:27AM +0800, Anson Huang wrote:
> On some i.MX SoCs' low power mode, such as i.MX7D's LPSR(low power
> state retention), UART iomux settings will be lost, need to add
> pinctrl sleep/default mode switch during suspend/resume to make
> sure UART iomux settings are correct after resume.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards
Uwe
-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
