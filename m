From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] serial: imx: drop CTS/RTS handling from shutdown
Date: Thu, 24 May 2018 19:44:25 +0200
Message-ID: <20180524174425.2b6b7xb7c6vvrodo@pengutronix.de>
References: <20180524173024.20936-1-sebastian.reichel@collabora.co.uk>
 <20180524173024.20936-2-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180524173024.20936-2-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, May 24, 2018 at 07:30:23PM +0200, Sebastian Reichel wrote:
> According to Documentation/serial/driver the shutdown function should
> not disable RTS, so drop it.
> 
> Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Great idea! :-)

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
