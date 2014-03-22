From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/8] Generic serial earlycon
Date: Sat, 22 Mar 2014 23:01:30 +0100
Message-ID: <201403222301.30222.arnd@arndb.de>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <201403221054.39799.arnd@arndb.de>
 <CAL_JsqKjGjyYypwneCmNc1qeKe0ZOG9gz3QSJ37-HwHXKu3iRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqKjGjyYypwneCmNc1qeKe0ZOG9gz3QSJ37-HwHXKu3iRA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "x86@kernel.org" <x86@kernel.org>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Saturday 22 March 2014, Rob Herring wrote:
> I think this series stands on its own. It is largely refactoring
> existing code and supporting existing command line options (arm64 just
> changes from earlyprintk= to earlycon=). There will be cases where
> changing the kernel command line is the only way to setup the
> earlycon. Also, I think we would still want the kernel command line to
> control whether or not we enable the earlycon (i.e. earlycon=dt).
> There's not a standard way for how bootloaders would decide to set
> "linux,stdout-path" or not.
> 
> The DT support won't be all that quick to implement. The challenge
> with the DT parsing is we have to do it on the flattened DT. I have
> something functioning, but it doesn't do any address translation which
> is the hard part.

Ah, I hadn't realized that we call parse_early_param() twice, both
in start_kernel() and before that in setup_arch(). You are right
that the first one of these can only look at the flat device tree
at the moment. I wonder if that's out of necessity or just coincidence
though.

There is relatively little going on between the first parse_early_param()
and the call to unflatten_device_tree(), so it may be possible to move
the former down, or the latter up.

        parse_early_param();

        sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);

        early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
        setup_dma_zone(mdesc);  
        sanity_check_meminfo();
        arm_memblock_init(&meminfo, mdesc);
                                
        paging_init(mdesc);
        request_standard_resources(mdesc);
                
        if (mdesc->restart)
                arm_pm_restart = mdesc->restart;
        
        unflatten_device_tree();

On powerpc, unflatten_device_tree is called way before paging_init, so I assume
it has to be possible, but it might end up being harder to do than what you
have in mind with parsing the flat device tree.

	Arnd
