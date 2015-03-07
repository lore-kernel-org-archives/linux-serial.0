From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial:imx make of_device_id array const
Date: Sat, 7 Mar 2015 03:51:17 +0100
Message-ID: <20150307025117.GA7616@kroah.com>
References: <1425280117-3861-1-git-send-email-sanjeev_sharma@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425280117-3861-1-git-send-email-sanjeev_sharma@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sanjeev Sharma <sanjeev_sharma@mentor.com>
Cc: jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Mar 02, 2015 at 12:38:37PM +0530, Sanjeev Sharma wrote:
> Make of_device_id array const.
> 
> Signed-off-by: Sanjeev Sharma <Sanjeev_Sharma@mentor.com>
> ---
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Someone else already sent this in before you did, sorry.

greg k-h
