From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c
 explicitly non-modular"
Date: Thu, 11 Feb 2016 17:06:32 +0100
Message-ID: <3873766.I9XIY0R8gT@wuerfel>
References: <1455205297-1021302-1-git-send-email-arnd@arndb.de>
 <1455205297-1021302-2-git-send-email-arnd@arndb.de>
 <20160211160021.GF28452@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160211160021.GF28452-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thursday 11 February 2016 11:00:22 Paul Gortmaker wrote:
> [[PATCH v2 1/6] Revert "drivers/tty/serial: make 8250/8250_mtk.c explicitly non-modular"] On 11/02/2016 (Thu 16:41) Arnd Bergmann wrote:
> 
> > This reverts commit d72d391c126e, which tried to remove dead code but
> > left the driver in a useless state when the main 8250 driver is a
> 
> Am I misunderstanding something?  The commit didn't cause the driver to
> be in a useless state for 8250=m.  But rather isn't that it was a
> pre-existing condition, independent of the change to 8250_mtk.c to
> remove the dead code in d72d391c126e?
> 
> Since the commit did not touch Kconfig or Makefile, I can't see how it
> could cause some new useless state that did not already exist, and hence
> the "Fixes:" tag is invalid as well.

My wording may have been bad here. What I meant to say is that it
was broken before the patch, and still broken after the patch.

The Fixes tag was meant to just be a reference to the commit I'm
reverting.

	Arnd
