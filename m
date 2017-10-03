From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] Use RX_BUF_SIZE to set size of RX buffer
Date: Tue, 3 Oct 2017 20:24:17 +0200
Message-ID: <20171003182417.GB19258@kroah.com>
References: <1506593260-14457-1-git-send-email-martyn.welch@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1506593260-14457-1-git-send-email-martyn.welch@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 28, 2017 at 11:07:40AM +0100, Martyn Welch wrote:
> The imx serial driver uses PAGE_SIZE when allocating rx_buf, but then
> uses RX_BUF_SIZE (which is currently defined as PAGE_SIZE) to describe
> the length of the buffer when initialising the scatter gather list.
> 
> In order to ensure that this stays consistent, use RX_BUF_SIZE in both
> locations.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> Acked-by: Uwe Kleine-König <u.kleine-könig@pengtronix.de>
> ---
> 
> v2: Add missing SoB and Uwe's Acked-by.

Your subject is missing "serial: imx:" :(

I'll go fix it up...
