Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9363317D354;
	Fri, 15 Nov 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731656819; cv=none; b=Ak0wt2a1XMnzV6O5wNzQLW/QIMkR4jQEStuPN+kI5EbUcRIdQPuo+tx07GOpfbxuCkVsmcvCAIXoUJ4Hf24DrKaGqRSyFdoQa+0dbz3X2Sl1KP9wa8bTYE1U29G0nuq1wpv+Ab4QTwHem2LSD8hYxSZs95SC8NKUbJ3mYeeU+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731656819; c=relaxed/simple;
	bh=Yn5H2K1hbNN2pRo3y5lGrHrmP1Raa0C4Moh+djHQYt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUtGQd6soIiwigkzDNrpEIcBFGJDiNP3K/0Ts1zEoBg88PzyhOOcx37sUhuHH51l8ELi35ElWIMU3Pv7KM9UkGX+0HrybLLVd9JuTpSXtW71Ms1CzRG/Qc7atvAshUF1XqLcPClIy+IKHwt5QeXG11BukS77RfhwQ0cvkohilzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUjwnJHl; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUjwnJHl"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2ea0bd709c0so1067839a91.3;
        Thu, 14 Nov 2024 23:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731656817; x=1732261617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZQ+Zr3Ocu23U0mYDZSaGtjvo9T3p9MWegkwHbx+FBA=;
        b=mUjwnJHlZPaU0p3jk/53bhKxzMYF8Ll5Vzfg98h1h0HiGZLrCyz6uhzS4RH1KZ/I+z
         Y0MC30j5SaPub88RPQajJKvlduslTXsF9i1uJ1oI53VM1FHRLOyv+vKSVT18x6XOWzsM
         h5cYiPmv25nxMqiSYBuUjzYafvh4cHZvQa9m+TbqGyc7LCBBW38eszOeuaX1kA3Hf2rY
         b0ge3lAeU6d0W/nIJ2Ca3HrBW5G/0dBG58yhiTzoAgm8H6dDZftLM6390FM5IHwGX7z2
         40ePrwDzTfl0Tz6pVn8zDJ5gFUnfEFTgnI8aOYtBIUEJMovpglxyDKoKscNr/Gpp2987
         I5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731656817; x=1732261617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZQ+Zr3Ocu23U0mYDZSaGtjvo9T3p9MWegkwHbx+FBA=;
        b=MBOGZQ58BG2cjUgZ/xvn/7CCgWsjth1yxdWf8S0YXhUvjhAeW0HLRAUWLTwsUPXWt1
         CzqitepjAVdMXra6yoFtWX4EokdyOMzH0ZACeCuyirA1UzfRl+OwXVqmPEvFCx/z9q9k
         cKJmqJTSuw90QR89tfRNeUFVADnQJbLMj7RuG9OYjUF/NHPFHNRvSzOM4iSrvsVNpyV0
         Eo7wx3GJR7GrR8wT9uweuvR3j0YNV8u6Ml1Tz2yGK8TNmT7oIoneIzxTzA++4ITDm3D9
         orMt2okLjV+EBs9KTU4z6iA7GpI4iZ3FppXqJinIyiEGx/ak7u3TduG467jl7SZGWkCs
         Ua4w==
X-Forwarded-Encrypted: i=1; AJvYcCVMyvqWfoMKDsb1EoexZKLl96CPuctc+/vE41gzqgH9qhYek/JL0gbE43/4UPS54YpMoaK2wUKdwN0jzXrN@vger.kernel.org, AJvYcCW0VHBqmTZLYkH3wQ8bVaX4iWqN3kLZpWIIaD9ApLRG+izk4T11PWCRPGVG8A8BtMoXZXa2mPFDnRxV@vger.kernel.org, AJvYcCWl1ZyNo25vVCfwN9a+AXejT9/JMun3BEy/Sc4iNhbEk/aPeIHxMhAwuNpaAt13gY1mVBOBiBK4J4pCfcf0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Lxgc4KLQArYU4/28UAPAQ+2JGnfr9gnl8ChTdeeohgK+fHd0
	mpBgKR/UuNFT+YBW2idFomX1FP4vXWotQamj88JcV3KCbxnVjZ8uncQDVr4zFObCSIBtZVXlNew
	bnqwZAFan+oVGRgr6g/u+F9sYeJk=
X-Google-Smtp-Source: AGHT+IFa5TVuuI7zGjEbWeGNLPDWke0uXRT8ztWH3KhLye10MaKUazSqhMGxJYhBjFNGrzc9q6a+UU6Kh75E3YCcyvk=
X-Received: by 2002:a17:90b:4f4b:b0:2e9:5d94:5992 with SMTP id
 98e67ed59e1d1-2ea15596ca3mr2015547a91.31.1731656816889; Thu, 14 Nov 2024
 23:46:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
 <20241113110516.2166328-2-Wenhua.Lin@unisoc.com> <3f89369f-7c0a-47c3-a22a-a125847edb98@linux.alibaba.com>
In-Reply-To: <3f89369f-7c0a-47c3-a22a-a125847edb98@linux.alibaba.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Fri, 15 Nov 2024 15:46:45 +0800
Message-ID: <CAB9BWhdi2Q3gViCPjYAUYeYktBKR_rc4DN5PqXKvAvA44LDd9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sprd: Add support for sc9632
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Cixi Geng <cixi.geng@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>, Zhaochen Su <Zhaochen.Su@unisoc.com>, 
	Zhirong Qiu <Zhirong.Qiu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:47=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/11/13 19:05, Wenhua Lin wrote:
> > Due to the platform's new project uart ip upgrade,
> > the new project's timeout interrupt needs to use bit17
> > while other projects' timeout interrupt needs to use
> > bit13, using private data to adapt and be compatible
> > with all projects.
> >
> > Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
> > ---
> >   drivers/tty/serial/sprd_serial.c | 41 ++++++++++++++++++++++++++++---=
-
> >   1 file changed, 36 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd=
_serial.c
> > index 3fc54cc02a1f..882580c3cf37 100644
> > --- a/drivers/tty/serial/sprd_serial.c
> > +++ b/drivers/tty/serial/sprd_serial.c
> > @@ -53,10 +53,12 @@
> >   #define SPRD_IEN_TX_EMPTY   BIT(1)
> >   #define SPRD_IEN_BREAK_DETECT       BIT(7)
> >   #define SPRD_IEN_TIMEOUT    BIT(13)
> > +#define SPRD_IEN_DATA_TIMEOUT        BIT(17)
>
> I don't know the meaning of 'DATA' in the new macro name. But I have no
> better name now:) Otherwise look good to me.
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Hi baolin:
  TIMEOUT means only timeout, DATA_TIMEOUT means timeout and fifo is not em=
pty.
  Therefore, the macro name is distinguished by adding DATA.

Thanks
