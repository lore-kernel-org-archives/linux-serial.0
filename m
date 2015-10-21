From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly
 non-modular
Date: Tue, 20 Oct 2015 20:20:07 -0400
Message-ID: <20151021002007.GA4588@windriver.com>
References: <1445206878-12455-1-git-send-email-paul.gortmaker@windriver.com>
 <20151020151052.GI3421@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151020151052.GI3421-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Anton Blanchard <anton-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

[Re: [PATCH 0/5] drivers/tty: make more bool drivers explicitly non-modular] On 20/10/2015 (Tue 17:10) Alexandre Belloni wrote:

> On 18/10/2015 at 18:21:13 -0400, Paul Gortmaker wrote :
> > The one common thread here for all the patches is that we also
> > scrap the .remove functions which would only be used for module
> > unload (impossible) and driver unbind.  For the drivers here, there
> > doesn't seem to be a sensible unbind use case (vs. e.g. a multiport
> > PCI ethernet driver where one port is unbound and passed through to
> > a kvm guest or similar).  Hence we just explicitly disallow any
> > driver unbind operations to help prevent root from doing something
> > illogical to the machine that they could have done previously.
> > 
> > We've already done this for drivers/tty/serial/mpsc.c previously.
> > 
> > Build tested for allmodconfig on ARM64 and powerpc for tty/tty-testing.
> > 
> 
> So, how does this actually build test atmel_serial?

Not sure why this should be a surprise;  I build test it exactly like this:

paul@builder-02:~/git/linux-head$ echo $ARCH
arm64
paul@builder-02:~/git/linux-head$ echo $CROSS_COMPILE 
aarch64-linux-gnu-
paul@builder-02:~/git/linux-head$ make O=../arm-build/  drivers/tty/serial/atmel_serial.o
make[1]: Entering directory '/home/paul/git/arm-build'
arch/arm64/Makefile:25: LSE atomics not supported by binutils
  CHK     include/config/kernel.release
  Using /home/paul/git/linux-head as source for kernel
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h

[...]

  HOSTCC  scripts/sign-file
  HOSTCC  scripts/extract-cert
  CC      drivers/tty/serial/atmel_serial.o
make[1]: Leaving directory '/home/paul/git/arm-build'
paul@builder-02:~/git/linux-head$ 

It did build; no warning/error.  Would you call it an invalid build test?

> 
> A proper solution would be to actually make it a tristate and allow
> building as a module. I think it currently fails because of
> console_initcall() but that is certainly fixable.

Well, as per other threads on this topic, if people want to extend
the functionality to support tristate, then great.  But please do
not confuse that with existing functionality which is clearly non
modular in this case.

Thanks,
Paul.
--

> 
> 
> -- 
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
