From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: make[2]: *** No rule to make target
 `drivers/serial/serial_core.c', needed by
 `Documentation/DocBook/kernel-api.xml'.
Date: Sat, 30 Mar 2013 13:32:52 +0800
Message-ID: <20130330053252.GB25547@localhost>
References: <5153256d.SyZXdcYq+1mLl7KI%fengguang.wu@intel.com>
 <20130328010012.GA14108@localhost>
 <20130329165115.GA26331@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130329165115.GA26331@kroah.com>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: serial <linux-serial@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
List-Id: linux-serial@vger.kernel.org

> >    make[2]: *** No rule to make target `block/blktrace.c', needed by `Documentation/DocBook/kernel-api.xml'.
> > >> make[2]: *** No rule to make target `drivers/serial/serial_core.c', needed by `Documentation/DocBook/kernel-api.xml'.
> > >> make[2]: *** No rule to make target `drivers/serial/8250.c', needed by `Documentation/DocBook/kernel-api.xml'.
> >    make[2]: *** No rule to make target `drivers/net/wan/syncppp.c', needed by `Documentation/DocBook/networking.xml'.
> >    make[2]: *** No rule to make target `arch/powerpc/kernel/rio.c', needed by `Documentation/DocBook/rapidio.xml'.
> >    make[2]: Target `htmldocs' not remade because of errors.
> 
> I can't duplicate this on my tree, sorry.

I'm so sorry! Please ignore all of these false reports on Documentation/DocBook/.

It's a problem with the build script.  Fixed by doing a
"make distclean" after building too old kernels:

        git checkout $some_years_old_kernel
        make htmldocs

        git checkout v3.8
+       make distclean     # bring $KBUILD_OUTPUT/Documentation/DocBook/ out of bad old state
        make htmldocs

Thanks,
Fengguang
