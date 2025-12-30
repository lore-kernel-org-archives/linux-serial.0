Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060E26F46E;
	Tue, 30 Dec 2025 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767127342; cv=none; b=Ji9EKZZdbJCVNJgWhPY5r12bCIeVs6WB6F0eWwNB7CcKr+FoERh+hsBgi8eQaLwDvAXZm41IdL/M4ZhBysoKM/iMm2QQCC36wsb0LgajopflwKVn5uDYt/NeSlJOUdI4duHPpKWlb0rAvZtneVDI+4X8/rWaXUD+mHLgkko+kSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767127342; c=relaxed/simple;
	bh=IEHgSmK9DSdwqfB+LkxNJaKyPgWsesKD0sHUhuAH+60=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MyAha16JLa9N9diID8O8IlSJpUiyd1YkL1m3I+cU1xYuhBcXVn1qsX6sA5Cez1mHZlmntzdJ2Ilt5zYlX6aI0RHu8zochrMX4xmVsiMwi83+gMsjqbIUKJxIP6pslEWyhMN1z35DIAsRIio0njinTEEGnqmNEZfBiDsXEPoTcqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b=lYKAVc+Y; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="lYKAVc+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767127321; x=1767732121; i=xypron.glpk@gmx.de;
	bh=FyGtKH0ot80SdgLGM72Q5ibg/Uleo8SNP3db1G88kZw=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lYKAVc+Yg3JDmoWO+LikwcejBubLYKvWJ+yckogj6sT2eXc9iK/MoF23WuQEayxB
	 eD9cznzwbsLH2QXY0a+EHwrzUlm1TSNM/rZCr0rsD1akyvOm9MW9A6daTtXaRXjgM
	 UsKmnzR/PJs/CyWr4rz+vjZKeCZTz5Jc2tVQq1lqnsiipSuqHun+3m1CxNy2V8ME0
	 kg5mXczVj7wparn9hsrzQEqlb86bvcoPbEzWsAgSzuYhaN+7w0Z2zqSx045heiY8B
	 SA3+ale4vXQUzdfhv+78QWOnau1HqOUL6tHbqSVtFnO9zvd630HW8jpGr5DEQEmNW
	 +icYvQYuS4ChVwdOLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([61.8.130.97]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1vfaMV0IGA-00GcxV; Tue, 30
 Dec 2025 21:42:01 +0100
Date: Tue, 30 Dec 2025 21:41:56 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>
CC: Alex Elder <elder@riscstar.com>, Guodong Xu <guodong@riscstar.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@gentoo.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>, Paul Walmsley <paul.walmsley@sifive.com>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_11/13=5D_dt-bindings=3A_r?=
 =?US-ASCII?Q?iscv=3A_Add_Supm_extension_description?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251230-budding-dimple-c34636b0ca4d@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com> <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com> <fc719e92-10bc-455f-b402-c93bdbf878cf@riscstar.com> <20251230021306.GA3094273-robh@kernel.org> <80e18a32-543a-48f5-81f2-4fa64cb8bf8c@riscstar.com> <CAL_JsqK8hRsVWV6WfbZ6hF1PwFfOJhyOrpWwoOhviAgv5ZxKUw@mail.gmail.com> <20251230-budding-dimple-c34636b0ca4d@spud>
Message-ID: <05B0AE03-E7B1-4DCD-88D0-DCB9053F30BA@gmx.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IEe3flgz+5avSsarVjA2gHSZ0QMvBCzHvM1E+AJ/AzV+hZfbEMN
 nSEazwZhzyvcbCGYlsvyOMT0TZg8z+/Zc/9rcjSUo1capLtDzdeUSotlHiO/mds+FwUec3H
 e2XJuXKKh1A72YtQqa1HQxIc7MfyF60aNy2f3YZtuL/PW3OK2JAcfNWskxCYB9WlE8g5w07
 bbiwKiqAZj8vv2IWGLXNg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K2AgcKU18KU=;jFiTFFJKuODnxyt3SYsknuBPrV1
 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
 RnAdQPB8=

Am 30=2E Dezember 2025 18:37:25 MEZ schrieb Conor Dooley <conor@kernel=2Eor=
g>:
>On Tue, Dec 30, 2025 at 09:21:56AM -0600, Rob Herring wrote:
>> On Mon, Dec 29, 2025 at 9:14=E2=80=AFPM Alex Elder <elder@riscstar=2Eco=
m> wrote:
>> >
>> > On 12/29/25 8:13 PM, Rob Herring wrote:
>> > > On Fri, Dec 26, 2025 at 03:28:47PM -0600, Alex Elder wrote:
>> > >> On 12/22/25 7:04 AM, Guodong Xu wrote:
>> > >>> Add description for the Supm extension=2E Supm indicates support =
for pointer
>> > >>> masking in user mode=2E Supm is mandatory for RVA23S64=2E
>> > >>>
>> > >>> The Supm extension is ratified in commit d70011dde6c2 ("Update to=
 ratified
>> > >>> state") of riscv-j-extension=2E
>> > >>>
>> > >>> Supm depends on either Smnpm or Ssnpm, so add a schema check to e=
nforce
>> > >>> this dependency=2E
>> > >>
>> > >> I have the same general question on this, about whether it's reall=
y
>> > >> necessary for the DT binding to enforce these requirements=2E  The
>> > >> RISC-V specifications are what truly defines their meaning, so I
>> > >> don't really see why the DT framework should need to enforce them=
=2E
>> > >> (That said, I'm sure there are other cases where DT enforces thing=
s
>> > >> it shouldn't have to=2E)
>> > >
>> > > Does the specification have some way to check it? What happens if a=
 DT
>> > > is wrong? Are you going to require a DT update to make things right=
? Or
>> > > the kernel has to work-around the error? Neither is great=2E So hav=
ing
>> > > this as a schema makes sense to prevent either scenario=2E
>> >
>> > I'm really glad you weighed in=2E  I actually have several questions
>> > related to RISC-V extensions and DT=2E  But for now I'll focus on
>> > just this=2E=2E=2E
>> >
>> > To answer your first question, I'm not sure how the specification
>> > is "checked", or what "it" is that you're asking about for that
>> > matter=2E  Also I think we have to be clear about what "wrong" means=
=2E
>> >
>> > RISC-V is defined by a (large and growing) set of specifications
>> > that are developed through a well-defined process=2E  When a spec
>> > is *ratified* it is committed, and it won't be changed=2E  These
>> > specifications are ultimately *the* definition of RISC-V
>> > compliance=2E
>> >
>> > I assumed the "wrong" you're talking about is a DTS/DTB that has
>> > been committed but somehow does not match what a RISC-V spec
>> > says, but I might be mistaken=2E
>>=20
>> That's correct=2E
>>=20
>> > Anyway, we can flip that around and have a similar problem:  What
>> > if we define the DT binding in such a way that it doesn't match
>> > the RISC-V spec?  The (ratified) RISC-V spec is right=2E
>>=20
>> Sure=2E Any time there is more than 1 source of truth, they could be
>> mismatched=2E But it is 1 spec and 1 schema to compare, not N DTS files=
=2E
>> Checking the schema matches the spec is much easier than reviewing
>> every new DTS file=2E
>
>The objective is not to define things with divergent meanings anyway,
>only to say "this string is exactly this version of this extension",
>so that if some other version of an extension comes along we have a way
>to differentiate=2E We didn't before and that became problematic for both
>standard extensions and vendor specific stuff=2E You'll note we don't loo=
k
>to define anything ourselves, just cite the spec that provides the
>definitions=2E
>
>> The only true fix is to make the spec machine readable=2E
>>=20
>> > My thought was that we should have software do the verification,
>> > and recommend the software (e=2Eg=2E arch/riscv/kernel/cpufeature=2Ec
>> > in Linux) be updated to verify things before committing to a
>> > DT binding=2E
>>=20
>> That moves validation from build time to run time=2E How is that better=
?
>> And what about other OSs?
>>=20
>> I'm very much of the opinion that it is not the kernel's job to
>> validate the DT=2E It obviously has not done a very good job given
>> issues we find with schemas=2E It's fine to have some checks in this
>> case if the kernel can't function (or use/enable the extension)
>> without the dependent extensions, but there are lots of classes of
>> errors the kernel doesn't need to care about=2E
>
>By and large what's in cpufeature=2Ec is there to turn extensions off
>based on kconfig choices (vector support enabled etc) or kernel design
>decisions (kernel requiring both d and f extensions for fpu support)=2E I

Should supm be handled in the same way? Add it to the device-tree of RVA23=
U64 devices=2E If a kernel does not support pointer masking in user space, =
hide the extension in cpufeature=2Ec=2E

Best regards

Heinrich

>don't think there's anything there that doesn't assume that the
>devicetree is correct=2E For my money, it's much simpler to describe
>dependencies in a binding than add more code to the kernel that tries to
>figure out dependencies at runtime=2E
>

