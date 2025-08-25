Received: from smtpout02-ext4.partage.renater.fr (smtpout02-ext4.partage.renater.fr [194.254.241.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA5A14F125;
	Mon, 25 Aug 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.254.241.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122073; cv=none; b=F0P0v2ww9j72tWQovnc8NrW5NbdMNTvC7v41kcNIoN95LxX8uhDhZhwPP73u1Q4w15wkbjhuRgyZ8ASRU5Mc8sn+1rl56dAGAnlOIFt89av/CXmh7ME39wBLN4FKVAKc/47trrQVABzdqKPEvF4RniPzv00n+ELfSbxM/TeYhbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122073; c=relaxed/simple;
	bh=qX50VbLoQ13NaBCeyIYENxxCd/IArQmdsbeRnc3ngfI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mAJEDtqgJx02VX5vgkqhWrBul4s7LoNTDOO5yVnn/YXOF+Brr/8LnH0rUGYsMxr5wYKcVt+0DafiIvEDbb3sG4VEAgPJyWcGHZQzjF2aVk67tYw3q9nRu4hskhWIw8zGaIFbUfzDrZ8R06ggyGheJTSrjv5A6Qmf4MSrvaRcueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org; spf=none smtp.mailfrom=grenoble-inp.org; dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b=VWW10mal; arc=none smtp.client-ip=194.254.241.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=grenoble-inp.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grenoble-inp.org header.i=@grenoble-inp.org header.b="VWW10mal"
Received: from zmtaauth02.partage.renater.fr (zmtaauth02.partage.renater.fr [194.254.241.25])
	by smtpout20.partage.renater.fr (Postfix) with ESMTP id CA941C0090;
	Mon, 25 Aug 2025 13:41:03 +0200 (CEST)
Received: from zmtaauth02.partage.renater.fr (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPS id BAD25A06D7;
	Mon, 25 Aug 2025 13:41:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTP id A76DBA0C56;
	Mon, 25 Aug 2025 13:41:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmtaauth02.partage.renater.fr A76DBA0C56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grenoble-inp.org;
	s=F42A61D9-9621-4693-8E8E-830FB5F1ED6E; t=1756122063;
	bh=qX50VbLoQ13NaBCeyIYENxxCd/IArQmdsbeRnc3ngfI=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=VWW10malf6pYYqOmW5vJGixqXmMB3VxlYkldGI+CTblOg8IhykmqJtAca3O7I1rZD
	 lAmlubLY7B71SS/Oq7o/IiD82e7asSgaRUgMm6Fivfz3LzYBDTl14+MDu22tKMUDXS
	 9I84x2OYmnSuEOmW1oAWALfU3DGJ6iMvhpjctU9h1wNVRJluMy668+2zZnX92U/MQF
	 XQtJfEYD6Zb88rXYHY4Fvz04jFXA1IJYjsbHsoNwz+VLJsjn5G/RpKdMCS2umiTS4z
	 oOYmWfU3xY9EAyfUX/BoJ7sNdlpTng4WxDK+HIjMdkzHAAjbOt7fb0W1uMNgNq67Th
	 sAWMn/MWVsUyA==
Received: from zmtaauth02.partage.renater.fr ([127.0.0.1])
 by localhost (zmtaauth02.partage.renater.fr [127.0.0.1]) (amavis, port 10026)
 with ESMTP id dqTo0IRUplCw; Mon, 25 Aug 2025 13:41:03 +0200 (CEST)
Received: from 91.166.147.41 (unknown [194.254.241.250])
	by zmtaauth02.partage.renater.fr (Postfix) with ESMTPA id B0F3BA06D7;
	Mon, 25 Aug 2025 13:41:02 +0200 (CEST)
Message-ID: <7f55fd6b-91ed-453c-902a-0f7c74e201f5@grenoble-inp.org>
Date: Mon, 25 Aug 2025 13:41:02 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Calixte Pernot <calixte.pernot@grenoble-inp.org>
Subject: Re: [PATCH] vt: add support for smput/rmput escape codes
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250824142016.47219-1-calixte.pernot@grenoble-inp.org>
 <e5f75c37-30a5-4c4e-aae5-a72060be24da@kernel.org>
Content-Language: en-US
Autocrypt: addr=calixte.pernot@grenoble-inp.org; keydata=
 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
In-Reply-To: <e5f75c37-30a5-4c4e-aae5-a72060be24da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Virus-Scanned: clamav-milter 0.103.12 at clamav02
X-Virus-Status: Clean
X-Renater-Ptge-SpamState: clean
X-Renater-Ptge-SpamScore: -100
X-Renater-Ptge-SpamCause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecutffgpfetvffgtfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeevrghlihigthgvucfrvghrnhhothcuoegtrghlihigthgvrdhpvghrnhhothesghhrvghnohgslhgvqdhinhhprdhorhhgqeenucggtffrrghtthgvrhhnpefggfdvheehfeehkeehfeffjeelveejfeekieejtdeiveeiudekieekvddvkeeggfenucfkphepudelgedrvdehgedrvdeguddrvdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleegrddvheegrddvgedurddvhedtpdhhvghlohepledurdduieeirddugeejrdeguddpmhgrihhlfhhrohhmpegtrghlihigthgvrdhpvghrnhhothesghhrvghnohgslhgvqdhinhhprdhorhhgpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepjhhirhhishhlrggshieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshgvrhhirghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Content-Transfer-Encoding: quoted-printable

Hi, thanks for your response.

On 8/25/25 07:47, Jiri Slaby wrote:
> Hi,
>
> On 24. 08. 25, 16:20, Calixte Pernot wrote:
>> Support "\e[?1049h" and "\e[?1049l" escape codes.
>> This patch allows programs to enter and leave alternate screens.
>> This feature is widely available in graphical terminal emulators and=20
>> mostly
>> used by fullscreen terminal-based user interfaces such as text editors=
.
>> Most editors such as vim and nano assume this escape code in not=20
>> supported
>> and will not try to print the escape sequence if TERM=3Dlinux.
>> To try out this patch, run `TERM=3Dxterm-256color vim` inside a VT.
>>
>> Signed-off-by: Calixte Pernot <calixte.pernot@grenoble-inp.org>
> ...
>> --- a/drivers/tty/vt/vt.c
>> +++ b/drivers/tty/vt/vt.c
> ...
>> @@ -1878,6 +1883,46 @@ static int get_bracketed_paste(struct=20
>> tty_struct *tty)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vc->vc_bracketed_paste;
>> =C2=A0 }
>> =C2=A0 +/* console_lock is held */
>> +static void enter_alt_screen(struct vc_data *vc)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned int size =3D vc->vc_rows * vc->vc_cols * =
2;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (vc->vc_saved_screen !=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return; /* Already inside =
an alt-screen */
>
> All this is protected by console_lock, right?=20

Yes. The 2 functions I added are called by csi_DEC_hl, itself protected=20
by console_lock.

console_lock() is called in do_con_write, and the call stack looks like=20
this:

do_con_write -> do_con_trol -> csi_DEC -> csi_DEC_hl ->=20
enter/leave_alt_screen

>> +=C2=A0=C2=A0=C2=A0 vc->vc_saved_screen =3D kzalloc(size, GFP_NOWAIT);
>
> Why GFP_NOWAIT?

To be honest I used the same flags as vc->vc_screenbuf, but after=20
"reading the F-ing manual", this seems unappropriate here.

"GFP_KERNEL implies GFP_RECLAIM, which means that direct reclaim may be=20
triggered under memory pressure; the calling context must be allowed to=20
sleep"

I guess we are allowed to sleep here (please correct me if i'm wrong),=20
so GFP_KERNEL must be more appropriate.

>> +=C2=A0=C2=A0=C2=A0 if (vc->vc_saved_screen =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 memcpy(vc->vc_saved_screen, (u16 *)vc->vc_origin, =
size);
>
> kmemdup();
>
>> ed_cols, vc->vc_cols);
>> +=C2=A0=C2=A0=C2=A0 unsigned short *src, *dest;
>
> u16
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (vc->vc_saved_screen =3D=3D NULL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return; /* Not inside an a=
lt-screen */
>> +=C2=A0=C2=A0=C2=A0 for (int r =3D 0; r < rows; r++) {
>
> unsigned
>> --- a/include/linux/console_struct.h
>> +++ b/include/linux/console_struct.h
>> @@ -159,6 +159,9 @@ struct vc_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uni_pagedict *uni_pagedict;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uni_pagedict **uni_pagedict_loc;=
 /* [!] Location of=20
>> uni_pagedict variable for this console */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 **vc_uni_lines;=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* unicode screen content *=
/
>> +=C2=A0=C2=A0=C2=A0 unsigned short=C2=A0=C2=A0=C2=A0 *vc_saved_screen;
>
> u16 *
>
>> +=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=A0 vc_saved_cols;
>> +=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=C2=A0 vc_saved_rows;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* additional information is in vt_kern=
.h */
>> =C2=A0 };
>
> thanks,

Thanks for the review, I'll rewrite the patch with the suggested changes=20
and send it back.

