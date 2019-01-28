From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
Date: Mon, 28 Jan 2019 10:30:59 +0100
Message-ID: <20190128093059.GA31657@kroah.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhou Yanjie <zhouyanjie@zoho.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, jslaby@suse.com, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 28, 2019 at 05:19:35PM +0800, Zhou Yanjie wrote:
> Add support for probing the 8250_ingenic driver on the
> X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  drivers/tty/serial/8250/8250_ingenic.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

You sent two different patches with the same subject: line, yet they did
totally different things.

Please fix this up and resend with a better set of subject lines.

thanks,

greg k-h
