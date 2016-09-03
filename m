From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] fs: add userspace critical mounts event support
Date: Fri, 2 Sep 2016 21:41:18 -0700
Message-ID: <CA+55aFz4q5peXAeY9h8o3he7R=wXrBSYkOjMM9TehOw=pPoS+Q@mail.gmail.com>
References: <1466117661-22075-1-git-send-email-mcgrof@kernel.org>
 <1466117661-22075-3-git-send-email-mcgrof@kernel.org>
 <CAKMK7uGAacZ5Lc1n5CiCVKgKWMS-H3S=8muD-LO+wQjpGnOdJw@mail.gmail.com>
 <20160824203901.GT3296@wotan.suse.de>
 <CAKMK7uEJtEr91SM6V3hZzwMyzTVXJanMtPcWM81RFH_Xyq9KVQ@mail.gmail.com>
 <20160825194133.GC3296@wotan.suse.de> <20160902235916.GO3296@wotan.suse.de>
 <20160903002014.GP3296@wotan.suse.de>
 <CA+55aFy4_QLYiQxtKpq0FJD7eSBRZ8nXS=Ruuz1TYodHdE_dCA@mail.gmail.com>
 <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=001a11403930ec27cf053b930ef1
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CAKdAkRSQmz3FoP8Z2ONm7-_A9RHF2Ox6snaCpsyS6HA7=+RerQ@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, Ming Lei <ming.lei@canonical.com>, Jeff Mahoney <jeffm@suse.com>, Kay Sievers <kay@vrfy.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, David Howells <dhowells@redhat.com>, Christian Lamparter <chunkeey@googlemail.com>, cocci@systeme.lip6.fr, Josh Boyer <jwboyer@fedoraproject.org>, Jonathan Corbet <corbet@lwn.net>, Kevin Cernekee <cernekee@gmail.com>, Thierry Martinez <martinez@nsup.org>, linux-serial <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Alessandro Rubini <rubini@gnudd.com>, Stephen Boyd <stephen.boyd@linaro.org>, Kees Cook <keescook@chromium.org>, Hauke Mehrtens <hauke@hauke-m.de>, nicolas.palix@imag.fr, "Abhay_Salunke@dell.com" <Abhay_Salunke@dell.com>, Julia Lawall <Julia.Lawall>
List-Id: linux-serial@vger.kernel.org

--001a11403930ec27cf053b930ef1
Content-Type: text/plain; charset=UTF-8

On Sep 2, 2016 9:20 PM, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
>
> Like what? Some devices do need to have firmware loaded so we know
> their capabilities, so we really can't push the firmware loading into
> "open".

So you
(a) document that
(b) make the driver only build as a module
(c) make sure the module and the firmware go together

End of problem.

Why make up random interfaces for crazy stuff?

     Linus

--001a11403930ec27cf053b930ef1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">On Sep 2, 2016 9:20 PM, &quot;Dmitry Torokhov&quot; &lt;<a h=
ref=3D"mailto:dmitry.torokhov@gmail.com">dmitry.torokhov@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Like what? Some devices do need to have firmware loaded so we know<br>
&gt; their capabilities, so we really can&#39;t push the firmware loading i=
nto<br>
&gt; &quot;open&quot;. </p>
<p dir=3D"ltr">So you<br>
 (a) document that<br>
 (b) make the driver only build as a module<br>
 (c) make sure the module and the firmware go together</p>
<p dir=3D"ltr">End of problem.</p>
<p dir=3D"ltr">Why make up random interfaces for crazy stuff?</p>
<p dir=3D"ltr">=C2=A0=C2=A0=C2=A0=C2=A0 Linus</p>

--001a11403930ec27cf053b930ef1--
