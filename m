From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
Date: Tue, 15 Dec 2015 17:29:50 -0500
Message-ID: <20151215222950.GH2772@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445206878-12455-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

[[PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 18/10/2015 (Sun 18:21) Paul Gortmaker wrote:

> This next set of patches to drivers/tty fixes up more drivers that would
> perhaps appear modular when looking at the code, but are controlled by
> a bool Kconfig.  We make sure they don't look modular and get rid
> of module related code in the drivers that would never be used.

[...]

> Paul Gortmaker (5):
>   drivers/tty: make hvc/hvc_vio.c explicitly non-modular
>   drivers/tty: make ehv_bytechan.c explicitly non-modular
>   drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular
>   drivers/tty/serial: make msm_serial.c explicitly non-modular
>   drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular

Hi Greg,

You've merged the #3 atmel patch and #5 the 8250_mtk patch; the msm_serial
patch (#4) is no longer applicable since the authors changed it to tristate.

That leaves the top two patches; both for PPC hardware.  Did you skip
those because you wanted them pushed through the powerpc tree?

If so, that is fine, I can do that.  Just let me know.

Thanks,
Paul.
--

> 
>  drivers/tty/ehv_bytechan.c         | 40 +++------------------------------
>  drivers/tty/hvc/hvc_vio.c          | 29 ++++--------------------
>  drivers/tty/serial/8250/8250_mtk.c | 35 ++++++-----------------------
>  drivers/tty/serial/atmel_serial.c  | 45 ++++----------------------------------
>  drivers/tty/serial/msm_serial.c    | 30 ++++---------------------
>  5 files changed, 22 insertions(+), 157 deletions(-)
> 
> -- 
> 2.6.1
> 
