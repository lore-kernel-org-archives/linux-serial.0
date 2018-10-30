From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
Date: Tue, 30 Oct 2018 15:20:13 -0700
Message-ID: <CAD=FV=URwUFep2UA7Xs1TxK6cZst+W-pfY2_BfKMZnGECHPZqw@mail.gmail.com>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-mips@linux-mips.org, dalias@libc.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, vigneshr@ti.com, linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, mhocko@suse.com, paulus@samba.org, mpe@ellerman.id.au, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>, marex@denx.de, Stephen Rothwell <sfr@canb.auug.org.au>, ysato@users.sourceforge.jp, linux-hexagon@vger.kernel.org, x86@kernel.org, Russell King - ARM Linux <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>, Ingo Molnar <mingo@redhat.com>, joel@jms.id.au, linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org, rolf.evers.fischer@aptiv.com, asierra@x
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, Oct 30, 2018 at 4:56 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> > Looking back, this is pretty much two series squashed that could be
> > treated indepdently.  The first is a serial series and the second is a
> > kgdb series.
>
> Indeed.
>
> I couldn't work out the link between the first 5 patches and the last 2
> until I read this...
>
> Is anything in the 01->05 patch set even related to kgdb? From the stack
> traces it looks to me like the lock dep warning would trigger for any
> sysrq. I think separating into two threads for v2 would be sensible.

Yes, sorry about the mess.  Splitting this into two series makes the
most sense.  Then I can focus more on trying to get the CCs right and
people can just get the patches that matter to them.

OK, I've sent v2 of both series out now.  Please yell if you can't
find them for whatever reason.

-Doug

-Doug
