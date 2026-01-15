Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774245BE3;
	Thu, 15 Jan 2026 06:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457988; cv=none; b=jaO3rAcsKEA/fYW6C6y4OKYXX6MMOaYyE5E/5oSXH5u20rN659cet8DlWgtN/azA8AGi4Cjo0yhK7cUviKKAMfJUB7uRk5vNSEoZdyIBq5RYiUpCsUC+CcDLbWAHsR09p2CxlzNiX0zjEDPUi1HBaH4a5E+Nhan8CRhhTnvCTT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457988; c=relaxed/simple;
	bh=Jx5JriAKAzcMhN4N5vt+itQQ6EQnEbLTcZYTyqLG/co=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YSKb2GM7tIAvm+b/XF0IZha/2ZVQN9V4A8eGR/rQZ3Vkrvo61ddD1x74C/934jOb6NzU9zeLStuRbauOW9dhMA3HOxhmg4R855zfXuc9SX5BStjQMqSTKSMMU7lXuqXTkx4t6rOmdAX7UqaBksr7aageh5H4WWeSFzZgH2Rpq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b=S9Z2RW4i; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="S9Z2RW4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768457972; x=1769062772; i=xypron.glpk@gmx.de;
	bh=3QmM6c+n5LHPp8BiY0+nbCGSMbrUC7GOi9i+SkR8G0s=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=S9Z2RW4iSoTpxD2O36yMA3f2Lig757t7KQg1imEhEJKeHNpfPREyVHXrlv00Ezh+
	 KXJG513xo372YR5SkfVdZqqHxfMq8VrZlUGXHK9O1eNeUWMnW0s0ivbLa/iprG5G0
	 lTZG04gIFgjVTYohDKtyKaNvuPA0r1Dp7Z+xuqSFCFVLKAgY+hDa2xtrIfvPSwBb4
	 6Cdqd2mwg1WF1RPMtD4VAuU5HZN6IT9mXW27B8zrOrKpjgYSdAYFcHn/gNbBAxBU4
	 yAoxq8y7Ms+kqPfEtGvEymcupHwAoCq7o989GiqiTp4HH7qrpFFoWN1F09eR2x3xh
	 GEm9bDwWGH8ek/JsCA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([46.114.7.140]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6KYl-1vrXBN0J6v-010Jqz; Thu, 15
 Jan 2026 07:19:32 +0100
Date: Thu, 15 Jan 2026 07:19:05 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Samuel Holland <samuel.holland@sifive.com>, Guodong Xu <guodong@riscstar.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>,
 Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, linux-serial@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
 Yangyu Chen <cyy@cyyself.name>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_10/11=5D_riscv=3A_dts=3A_spacemit=3A?=
 =?US-ASCII?Q?_add_initial_device_tree_of_SpacemiT_K3_SoC?=
User-Agent: Thunderbird for Android
In-Reply-To: <fd95c2f2-9292-483c-9613-4adf3c65c500@sifive.com>
References: <20260108-k3-basic-dt-v3-0-ed99eb4c3ad3@riscstar.com> <20260108-k3-basic-dt-v3-10-ed99eb4c3ad3@riscstar.com> <77f9a001-7f0a-4c29-abcb-501e875da117@sifive.com> <CAH1PCMZ5rKbG8xEbB9jt6TqyB28T5aLgRtf3iJ8Gt6Fk+3XFhQ@mail.gmail.com> <fd95c2f2-9292-483c-9613-4adf3c65c500@sifive.com>
Message-ID: <F93D26A6-60BE-4D50-A0BF-4BDF240149BE@gmx.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qosSXNkh7FrYVo7UIWYTrQ6xN0zsPd7Jd+QnnPDNTtONkmzUtJC
 XkY0hhJcnGb7Kq4djtOFmCVK4MNva21t/oeK8ufXwOAdzFUYeH1PjlAV4JBKXiGdqU/dTj4
 iK06UEUINK847/OsFeykJ2RQtWNN95IkJ/QT9RrbvT5RFl2W2NVj+N2kQrE7rcQ6S0SeZh3
 bnJ/h7X5JgUkJOuwq5iAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HiiUSqHtN4M=;/83JT22YWZrDgCt0tmZQuydaoY8
 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

Am 15=2E Januar 2026 00:57:04 MEZ schrieb Samuel Holland <samuel=2Eholland@=
sifive=2Ecom>:
>Hi Guodong,
>
>On 2026-01-09 3:58 AM, Guodong Xu wrote:
>> Hi, Samuel
>>=20
>> On Fri, Jan 9, 2026 at 2:19=E2=80=AFAM Samuel Holland <samuel=2Eholland=
@sifive=2Ecom> wrote:
>>>
>>> On 2026-01-08 6:26 AM, Guodong Xu wrote:
>>>> SpacemiT K3 is equipped with 8 X100 cores, which are RVA23 compliant=
=2E
>>>> Add nodes of uarts, timer and interrupt-controllers=2E
>>>>
>>>> Signed-off-by: Guodong Xu <guodong@riscstar=2Ecom>
>>>> ---
>>>> v3: Remove "supm" from the riscv,isa-extensions list=2E
>>>> v2: Remove aliases from k3=2Edtsi, they should be in board DTS=2E
>>>>     Updated riscv,isa-extensions with new extensions from the extensi=
ons=2Eyaml
>>>> ---
>>>>  arch/riscv/boot/dts/spacemit/k3=2Edtsi | 548 +++++++++++++++++++++++=
++++++++++++
>>>>  1 file changed, 548 insertions(+)
>>>>
>>>> diff --git a/arch/riscv/boot/dts/spacemit/k3=2Edtsi b/arch/riscv/boot=
/dts/spacemit/k3=2Edtsi
>>>> new file mode 100644
>>>> index 0000000000000000000000000000000000000000=2E=2Ebe9335fba32cb9e81=
915b2b91cf08c55a5e96809
>>>> --- /dev/null
>>>> +++ b/arch/riscv/boot/dts/spacemit/k3=2Edtsi
>>>> [=2E=2E=2E]
>>>> +                     reg =3D <0x0 0xe0400000 0x0 0x00200000>;
>>>> +                     interrupt-controller;
>>>> +                     #interrupt-cells =3D <0>;
>>>> +                     msi-controller;
>>>> +                     #msi-cells =3D <0>;
>>>> +                     interrupts-extended =3D <&cpu0_intc 9>, <&cpu1_=
intc 9>,
>>>> +                                           <&cpu2_intc 9>, <&cpu3_in=
tc 9>,
>>>> +                                           <&cpu4_intc 9>, <&cpu5_in=
tc 9>,
>>>> +                                           <&cpu6_intc 9>, <&cpu7_in=
tc 9>;
>>>> +                     riscv,num-ids =3D <511>;
>>>> +                     riscv,num-guest-ids =3D <511>;
>>>> +                     riscv,hart-index-bits =3D <4>;
>>>> +                     riscv,guest-index-bits =3D <6>;
>>>> +             };
>>>> +
>>>> +             saplic: interrupt-controller@e0804000 {
>>>> +                     compatible =3D "spacemit,k3-aplic", "riscv,apli=
c";
>>>> +                     reg =3D <0x0 0xe0804000 0x0 0x4000>;
>>>> +                     msi-parent =3D <&simsic>;
>>>> +                     #interrupt-cells =3D <2>;
>>>> +                     interrupt-controller;
>>>> +                     riscv,num-sources =3D <512>;
>>>> +             };
>>>
>>> Does the chip also have M-mode IMSIC and APLIC instances? Those need t=
o be
>>> represented in the devicetree as well, for M-mode firmware to access t=
hem, just
>>> like the CLINT below=2E
>>=20
>> Yes, the K3 chip does have M-mode IMSIC and APLIC instances=2E Currentl=
y, the
>> boot firmware (U-Boot) transfers information about these nodes to OpenS=
BI=2E
>> However, you are correct that they should be properly described in the =
DT=2E
>>=20
>> In the next version, I will add the M-mode APLIC (maplic) and IMSIC (mi=
msic)
>> nodes to k3=2Edtsi, for topology representation and potential firmware =
usage=2E
>> I will set their status to "disabled" because exposing them as "okay" t=
o Linux
>> causes access faults during driver probing=2E
>>=20
>> Please let me know if this approach (adding them but keeping them disab=
led)
>> looks okay to you=2E
>
>I think this is a reasonable compromise=2E
>
>Personally, I think of the DTS files in the Linux repository as the "stat=
ic"
>devicetree, which should describe a "complete" view of the hardware--that=
 is, as
>seen from the highest privilege level=2E Then it is the responsibility of=
 that
>highly-privileged software to modify the FDT as needed to provide a limit=
ed view
>of the hardware to lower-privileged software=2E And this modification is =
exactly
>what OpenSBI does before it passes the FDT to U-Boot=2E So the "static" d=
evicetree
>would not disable these M-mode-only devices=2E
>
>However, I recognize that people want to use the DTB files generated by t=
he
>Linux build process with Linux directly, ignoring the firmware-provided F=
DT=2E In
>that cases the M-mode-only devices need to be disabled=2E And then you ne=
ed a
>-u-boot=2Edtsi file to set `status =3D "okay"` for the firmware build=2E =
I think

U-Boot offers the EFI_DT_FIXUP_PROTOCOL (https://github=2Ecom/U-Boot-EFI/E=
FI_DT_FIXUP_PROTOCOL) to adjust device-trees loaded by systemd-boot or GRUB=
=2E

The disabling should be done there to avoid having different device-trees =
in firmware and Linux code=2E

A pull request for providing the protocol in EDK II is pending=2E

Best regards

Heinrich

>that's a reasonable compromise to make the "static" devicetree as complet=
e as
>possible while still being usable directly in S-mode in some cases=2E (It=
 still
>breaks if some peripheral is assigned to a different supervisor domain, o=
r some
>DRAM is reserved by M-mode, etc=2E, which is why I really recommend using=
 the
>firmware FDT and not a file=2E)
>
>Regards,
>Samuel
>

