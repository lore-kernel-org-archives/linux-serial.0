From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Date: Wed, 28 Oct 2009 21:11:29 +0100
Message-ID: <f861ec6f0910281311x21b07bd1u4e7e4401e395bc56@mail.gmail.com>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
	 <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
	 <20091028122430.f7670ae2.akpm@linux-foundation.org>
	 <f861ec6f0910281227t455a6f5cw9e492a9a1fc1b07e@mail.gmail.com>
	 <20091028125203.c513883e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0023545307d0754afb0477046618
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20091028125203.c513883e.akpm@linux-foundation.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: linux-serial@vger.kernel.org

--0023545307d0754afb0477046618
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Oct 28, 2009 at 8:52 PM, Andrew Morton <akpm@linux-foundation.org>wrote:

> On Wed, 28 Oct 2009 20:27:16 +0100
> Manuel Lauss <manuel.lauss@googlemail.com> wrote:
>
> > On Wed, Oct 28, 2009 at 8:24 PM, Andrew Morton <
> akpm@linux-foundation.org>wrote:
> >
> > > On Wed, 28 Oct 2009 20:09:14 +0100
> > > Manuel Lauss <manuel.lauss@googlemail.com> wrote:
> > >
> > > > UART autodetection breaks on the Au1300 but the IP blocks are
> > > > identical, at least in the datasheets.
> > > >
> > > > Pass uart type on to the 8250 driver via platform data, and move
> > > > the MSR quirk to another place sind autoconf() is now no longer
> > > > called on init.
> > > >
> > > > Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> > > > ---
> > > > Tested on DB1200 and DB1300.
> > > > The mips parts apply on top of Ralf's mips-queue tree.
> > > >
> > > >  arch/mips/alchemy/common/platform.c |    4 +++-
> > > >  drivers/serial/8250.c               |   13 +++++++------
> > > >  2 files changed, 10 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/arch/mips/alchemy/common/platform.c
> > > b/arch/mips/alchemy/common/platform.c
> > > > index 195e5b3..3be14b0 100644
> > > > --- a/arch/mips/alchemy/common/platform.c
> > > > +++ b/arch/mips/alchemy/common/platform.c
> > > > @@ -26,7 +26,9 @@
> > > >               .irq            = _irq,                         \
> > > >               .regshift       = 2,                            \
> > > >               .iotype         = UPIO_AU,                      \
> > > > -             .flags          = UPF_SKIP_TEST | UPF_IOREMAP   \
> > > > +             .flags          = UPF_SKIP_TEST | UPF_IOREMAP | \
> > > > +                               UPF_FIXED_TYPE,               \
> > > > +             .type           = PORT_16550A,                  \
> > > >       }
> > >
> > > The kernel which you patched differs from current mainline here.
> >
> >
> >  I know, that's why I added "The mips parts apply on top of Ralf's
> > mips-queue tree" below
> > the patch description.
>
> If that's the case then Ralf's mips-queue tree isn't in linux-next :(
>
> > If it makes it easier to apply, I could split this one in a mips and in a
> > 8250 patch?
>
> That's a hard call without knowing what's going on in mipsworld.  If
> these patches applied to current mainline we could do it all as one
> patch and, with suitable acks, slap it into 2.6.32.
>

The 8250.c hunks from both patches apply against current -git; only the
mips hunk is against Ralfs queue tree (the mips hunk on its own would
probably break something wrt. modem signals which I can't test now anyway)

I'll resend with a new series: 1 patch with the mips part (to Ralf)
and one with the 8250.c part (to you).



> Are these fixes also appropriate to 2.6.31.x and earlier?  If so,
>

Not really; patch #1 is necessary to get serial going on a chip not
yet supported in mainline, and patch #2 works around failing uart
autodetection on this new soc.


> that's another reason to prepare the patches against current mainline
> and just trample over the mips devel queue.
>

Understood.

Thank you!
     Manuel Lauss

--0023545307d0754afb0477046618
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Oct 28, 2009 at 8:52 PM, Andrew =
Morton <span dir=3D"ltr">&lt;<a href=3D"mailto:akpm@linux-foundation.org">a=
kpm@linux-foundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
On Wed, 28 Oct 2009 20:27:16 +0100<br>
<div><div></div><div class=3D"h5">Manuel Lauss &lt;<a href=3D"mailto:manuel=
.lauss@googlemail.com">manuel.lauss@googlemail.com</a>&gt; wrote:<br>
<br>
&gt; On Wed, Oct 28, 2009 at 8:24 PM, Andrew Morton &lt;<a href=3D"mailto:a=
kpm@linux-foundation.org">akpm@linux-foundation.org</a>&gt;wrote:<br>
&gt;<br>
&gt; &gt; On Wed, 28 Oct 2009 20:09:14 +0100<br>
&gt; &gt; Manuel Lauss &lt;<a href=3D"mailto:manuel.lauss@googlemail.com">m=
anuel.lauss@googlemail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; UART autodetection breaks on the Au1300 but the IP blocks ar=
e<br>
&gt; &gt; &gt; identical, at least in the datasheets.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Pass uart type on to the 8250 driver via platform data, and =
move<br>
&gt; &gt; &gt; the MSR quirk to another place sind autoconf() is now no lon=
ger<br>
&gt; &gt; &gt; called on init.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Signed-off-by: Manuel Lauss &lt;<a href=3D"mailto:manuel.lau=
ss@gmail.com">manuel.lauss@gmail.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; Tested on DB1200 and DB1300.<br>
&gt; &gt; &gt; The mips parts apply on top of Ralf&#39;s mips-queue tree.<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =A0arch/mips/alchemy/common/platform.c | =A0 =A04 +++-<br>
&gt; &gt; &gt; =A0drivers/serial/8250.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 1=
3 +++++++------<br>
&gt; &gt; &gt; =A02 files changed, 10 insertions(+), 7 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/arch/mips/alchemy/common/platform.c<br>
&gt; &gt; b/arch/mips/alchemy/common/platform.c<br>
&gt; &gt; &gt; index 195e5b3..3be14b0 100644<br>
&gt; &gt; &gt; --- a/arch/mips/alchemy/common/platform.c<br>
&gt; &gt; &gt; +++ b/arch/mips/alchemy/common/platform.c<br>
&gt; &gt; &gt; @@ -26,7 +26,9 @@<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D =
_irq, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 2, =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0 =3D UPIO=
_AU, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; &gt; - =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_=
SKIP_TEST | UPF_IOREMAP =A0 \<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_=
SKIP_TEST | UPF_IOREMAP | \<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 UPF_FIXED_TYPE, =A0 =A0 =A0 =A0 =A0 =A0 =A0 \<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D PORT=
_16550A, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\<br>
&gt; &gt; &gt; =A0 =A0 =A0 }<br>
&gt; &gt;<br>
&gt; &gt; The kernel which you patched differs from current mainline here.<=
br>
&gt;<br>
&gt;<br>
&gt; =A0I know, that&#39;s why I added &quot;The mips parts apply on top of=
 Ralf&#39;s<br>
&gt; mips-queue tree&quot; below<br>
&gt; the patch description.<br>
<br>
</div></div>If that&#39;s the case then Ralf&#39;s mips-queue tree isn&#39;=
t in linux-next :(<br>
<div class=3D"im"><br>
&gt; If it makes it easier to apply, I could split this one in a mips and i=
n a<br>
&gt; 8250 patch?<br>
<br>
</div>That&#39;s a hard call without knowing what&#39;s going on in mipswor=
ld. =A0If<br>
these patches applied to current mainline we could do it all as one<br>
patch and, with suitable acks, slap it into 2.6.32.<br></blockquote><div><b=
r>The 8250.c hunks from both patches apply against current -git; only the<b=
r>mips hunk is against Ralfs queue tree (the mips hunk on its own would<br>
probably break something wrt. modem signals which I can&#39;t test now anyw=
ay)<br><br>I&#39;ll resend with a new series: 1 patch with the mips part (t=
o Ralf) <br>and one with the 8250.c part (to you).<br><br>=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204=
); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Are these fixes also appropriate to 2.6.31.x and earlier? =A0If so,<br></bl=
ockquote><div><br>Not really; patch #1 is necessary to get serial going on =
a chip not<br>yet supported in mainline, and patch #2 works around failing =
uart<br>
autodetection on this new soc.<br>=A0</div><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
that&#39;s another reason to prepare the patches against current mainline<b=
r>
and just trample over the mips devel queue.<br>
</blockquote></div><br>Understood.<br><br>Thank you!<br>=A0=A0=A0=A0 Manuel=
 Lauss<br>

--0023545307d0754afb0477046618--
