From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] tty: serial: imx: add pinctrl sleep/default mode
 switch for suspend
Date: Tue, 4 Sep 2018 22:33:06 +0200
Message-ID: <20180904203306.ysnigbtkgsah3wrk@pengutronix.de>
References: <1533809169-24133-1-git-send-email-Anson.Huang@nxp.com>
 <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533809169-24133-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Linux-imx@nxp.com
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 09, 2018 at 06:06:09PM +0800, Anson Huang wrote:
> On some i.MX SoCs' low power mode, UART iomux settings

Would be nice to point out specific affected SoCs.

> may be lost, need to add pinctrl sleep/default mode switch
> during suspend/resume to make sure UART iomux settings are
> correct after resume.

Otherwise the change looks fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
