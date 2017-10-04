From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] serial: imx: Correct comment imx_flush_buffer()
Date: Wed, 4 Oct 2017 19:32:45 +0200
Message-ID: <20171004173245.vpxadn6qckhdrnvf@pengutronix.de>
References: <1507133607-22966-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507133607-22966-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 04, 2017 at 05:13:27PM +0100, Martyn Welch wrote:
> The comment in imx_flush_buffer() states that the state of 4 registers
> are to be saved/restored, then only saves and restores 3 registers. The
> missing register (UBRC) is read only and thus can't be restored.
> 
> Update the comment to reflect reality.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
