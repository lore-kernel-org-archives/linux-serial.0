Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794423665;
	b=PRSm4wC+MuB9/P2s2ns78SIGIQgQFEmYNX7IlPD1SyMRO4dKbE5vn7fPGQAwBef/LU0g
	 x8XffKwkPAekYiNdBJxK13/VoHTT2SwlExmYTLPVuepIw7WGti2IllMUUQBEpsrgB/hK3
	 rCSK4Ag7NOYAmD4TyPM4eMMx+HFRiJ39mlUyDsnZWlPA+XcbBn7Agf1BjQ7ak/lelLyYv
	 AMRsLB2uL6PjJ7jOg9cjnDH+aP4T3QKt1ZE7o/+zuw+UmXiObIEUggVjRx0q63E9P6trm
	 ik/ytWWi6eu0Ey+fs2DZprKpBknfXvFvuW7nsi4ed2DAunSGLXS3559COVjyEFxRnVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FhExMibayfnhhZfuPps5vX6y0sziM39MHH7rzV1Ch6U=;
	b=DbCB3WWLMPREdJGw4fOyZhEGOwt2DMwcqla93IWNl7q+yy5waB9uAH14Ja/ElAOBSqMG
	 nAEhhgPPJM1XD9lhtewDYHKeg7Vz3Y+E1SpOD0459hrzm4VXYjUuSQnavHye7cJUq+V1X
	 zfOHE+Eu07ae8FMC1Om8TjYtCZNByKk2Vs0TR1iX+96fmMIPTNB3Pbygw8R0F7rW/XM+o
	 dvUU+5mevZrIocQGDK5Sq/I020xCtN+iScNz2AYR6XWHJ+wDcyG6D7immRCV+wCLTs6QP
	 LeRaJ1+iVXYIxPTrAJWgZDoygwQpiO23w/naKnjqFIA2NKqAgRnAfPDLbByfZ0LTLzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DImU0jwV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63277606A324
	for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 19:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63277606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DImU0jwV
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37071c0f42aso5952668eec.0
        for <linux-serial@vger.kernel.org>; Wed, 11 Nov 2026 11:01:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794423664; cv=none;
        d=google.com; s=arc-20260327;
        b=dS3KZpnnTIrKZ9usDPki42o8CFivVir3v2vIYtvi+ktNTxznWjsvCPyIroJAgk9JTU
         tGg0yiS7cfXycVxuCMdLTRYgGjX/WTvZd9CGqtpZlKgJkKAlOPn8MtcM6cs/LL+i87Gh
         QTxZvehXbS0lKkaTFa0ja8LaiNImsEujhQc2oXPnHDMC64IAzEzYKAZDml7vf7tiD8MS
         cXxIRuwPPQwKte2hymgZj1c3SnpzyXcR4HJeP12eXbmdI1+rDiXwQBFqYudMoXwIcpQI
         SUzqolAfyHha3i8ayb15o53WbmvpYFJKr8CmGytntM12rA2YZe7doxEZ3PXRUTbrw92Z
         ZWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FhExMibayfnhhZfuPps5vX6y0sziM39MHH7rzV1Ch6U=;
        fh=uQgfWYcH1+P2FQ/sMnvrnEm75kTLTHb8bOW2b4S6W4s=;
        b=H+pRGFGOxgxQvH1RuGkeUs2/pfrSb57xi1OWcc45I8qQbE6XdVhj6+F/8KUnf7whwn
         TXi+HC2kCeqdUwvMU8FD5G20S1bYUI7bK5wq1oQ7XrzJE45ypMTRy5HFoFFl80kmq4dC
         oO73ceeDx6QVgibmkboD6Bjhui2gpto3wAcVCS4vhu3cB8Dy03Kem5IYplTM69xf790t
         +EUhwWda/IJ327xsSIhytu8jrBjcbpARuTcXumkY6kA/EgKsRXVZz0+BmfNqmK1G3pUi
         +g70jWQKIyb9Nd33QH+3nuLXcgeYJcM04j30aoQUGhojm8ENLo5kusumSchM/4BPorHD
         /B0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794423664; x=1795028464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FhExMibayfnhhZfuPps5vX6y0sziM39MHH7rzV1Ch6U=;
        b=DImU0jwVRZ0iBjCn/ZQkLB+58dSM/Q/ZXj21OcZPX/pxaNKEzvfEQkWYG3CEHRD4eT
         UDhh5QD1NU7TT8wO0nNPjyVuopL7ax2aldPc/bbRWcReQ3VMHUj0y5eKaLzaykJHpAtz
         AUdNid6qIAizZeyNaVypQMUMZ5kfFGh0i70fCsbXp/ZaYDBAAfdwlTHeNlyVGLilbXI3
         gnLhnIbUWGT3IaY2xifUvIgGylWSH4/0bMX3/6GTrwy06r4gws58PlOfKjx7QlmmLnu8
         B4/ZLNZrU0Sw4dbadUeUIxkK9EpZXTBEEKWplKLHx+ITMnw1lT2y/YnyZR+IfRCOGPiJ
         SC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423664; x=1795028464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FhExMibayfnhhZfuPps5vX6y0sziM39MHH7rzV1Ch6U=;
        b=NN7I3Xk/p5h666zIWaoHUU2pHJQ+UI12cR12jWs3Oi+h9aXi+9GuAD+8ehZnW3iTMk
         ceQN1r/0/j2oP9XKAexWkHwplobA6Ua5bTO2fJoKqBV0X/enGeGvk2xBNIW2mdGXF+PF
         7EupN5wdFkTxwP4WCjcLWQuoVN3gfIy+EfbIg/AIgFj1UkdVRFwdJZMb/4+JT9G6pFg0
         5c7CjM+8SS5dI9flcbjxvuJ+FdOv+Dgj7OUc4IZ0T9xpBX4Tq1hxfNrEPblLytXdC/k6
         TIr9ETNi41EPHYAWcfvFduQiOS8avdPlHyRMVONSvRHR1niLX4Zn7pvjIBLuqOxRDiIb
         55uw==
X-Forwarded-Encrypted: i=1; AL+hErGUAJHOVU0Bh6BEkg8p/KuuhZKWHkf+2mGAL4lEaGNs4Mtigvort2SMvw8Q7mCHXiS9I1u9dB8jmfMZGzY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qBKk1i/kd/2Ll9Ir/E8mWL1GQJS5233pu5p3GRQ39cX4jZ3H+
	wV2igeNXAPITkrywuJX0ZfJqB7Y8Ydf4IYS5DlSvxCMfVP1VQsvZOL7gjziytm8FamDe1QaK7e3
	TRz2+aPZ7bAhTGejndEbsb0scUNj2Wk0=
X-Gm-Gg: AYBFou0ClJHLd0AraL5aWbqI6c+P99Qg7sVcjojJ/9uTCB2mc62AFgR38EhTTaEa+T7
	W++vfoKZ30Y/9tm6mOB9dc4Cn7o2gswv8oFYhMKS8uxnB3KZoXL6JQit6fEbujgKnwdGsXtq8iJ
	noLkFtC6ba6sB+Idb9eBppskdfxqqPbFjN5bBKs9rZB+Ca+KYpJSMeC7WIzuEw9ljC6LslblfD5
	c6DrEwLRj7OG53+rX8tAduMCsk+fw93Ct7uPJt0+HwsGJveuacNdv8EwZ2pkkCA6xfjiqT3zkGr
	/O2JZmNZQN8l/LOfEsHU6iTE5o8A8Zp6rKocRLfS5LsfdzHhBaHCkyqkUiay3ZaH4HvZ4FHciVZ
	LAjwPCGyZ738G3BjVSbOeQx6D8mLXbShTZ7VP1A47p44/yQAB7q1WsdI5zkQf9hEYwYxeXEsN85
	z2ly5BOZ6ZuZxLGgVW
X-Received: by 2002:a05:7300:aca6:b0:36a:15cb:30bf with SMTP id
 5a478bee46e88-3768579fd19mr5126531eec.13.1794423663932; Wed, 11 Nov 2026
 11:01:03 -0800 (PST)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106010611.1708587-1-lcy8047@gmail.com> <89544da0-7c18-4fe5-8005-131760a2b8b5@arm.com>
 <8a20b9a9-b10c-4b7f-8d42-2e8c60edd943@app.fastmail.com>
In-Reply-To: <8a20b9a9-b10c-4b7f-8d42-2e8c60edd943@app.fastmail.com>
From: Changyul Lee <lcy8047@gmail.com>
Date: Wed, 11 Nov 2026 14:00:52 -0500
X-Gm-Features: AclHuK-2wDvDd_YZaNx0NfT3zLBUdDhEM6_NJ0-1AP9VmFhU-7GE9k2k4Tj3_HE
Message-ID: <CAKefsHt+LO=1f_AvOmr1hpG1LreUXby_qmjhgBed9FESxgnPJw@mail.gmail.com>
Subject: Re: [PATCH] serial: mps2-uart: Remove the ports_idr entry when probe fails
To: Arnd Bergmann <arnd@kernel.org>
Cc: Vladimir Murzin <vladimir.murzin@arm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the advice, Arnd. I will keep that in mind.

Changyul

2026=EB=85=84 11=EC=9B=94 11=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 11:30,=
 Arnd Bergmann <arnd@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Nov 11, 2026, at 15:17, Vladimir Murzin wrote:
> > On 11/6/26 01:06, Changyul Lee wrote:
> >
> > Before getting into the review, I'd like to clarify a few things:
> >
> > - This driver is only used on a NOMMU platform, where any code
> >   can write to any memory location, so the security impact of
> >   this issue is likely minimal
> >
> > - The only platform that uses this driver is deprecated and
> >   scheduled for removal [1], with the driver to be removed
> >   afterwards
> >
> > @Arnd, could you please advise on how to proceed? Should we
> > review the patch, leave things as they are, or take a different
> > approach?
> >
> > [1]
> > https://lore.kernel.org/linux-arm-kernel/20260908152808.3928630-12-arnd=
@kernel.org/
>
> I don't think it's super important, either applying as-is
> or ignoring seems fine, just don't spend too much time
> on a review.
>
> For some of the platforms I'm planning to remove it would
> be nice to backport fixesto the LTS kernels in case there
> are some users after all.
>
> Chanyul, it looks like you've done a thorough job testing this
> patch, and you probably have similar work for other drivers
> coming. I would suggest you try to prioritize the drivers that
> are likely to be in use somewhere.
>
> I have a branch for removing a lot of drivers including this
> one, maybe check your other patches to see which ones are
> obsolete.
>
>       Arnd
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/l=
og/?h=3Dboard-remove-7.4
