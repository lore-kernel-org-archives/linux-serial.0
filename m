Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E97239186;
	Wed,  4 Dec 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733346576; cv=none; b=YzV6rkf6wDpHH4bWe5WxyQuoy04Bkqvem2VeBH6pDBEsYoYWudQN7fsyncQRCvUbr5DcTPHHw4tFHkxNSn3Uc1Ey9PBUc+eTVgRutug8o6hoB119SPPqJojs+1zkxmHnjHqACml6n0kiXJN6rk8b0ORN4dlZsSWGVFEo0wRQ++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733346576; c=relaxed/simple;
	bh=HHI/wqRTU9L/rEvPeavJZItBrYALNq95bjy91XNqUeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oglgZhHFnLVsVN+eWEu0gCujOt7VRlcy7pMrva21u+pbi3tDmMWCjNQLYF0jGRV4llU23WFRX0Flk2RM3nXEZXJ+lq3VY3kbXPCuVkxUxwJ2jViKgZQ7yXZTduVFczWuqksBh4YgKB1mcpE45xAr1pHGXwbTf6aSBAb3HhWuQDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDA6qxJK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDA6qxJK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215b13e9ccbso1880255ad.0;
        Wed, 04 Dec 2024 13:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733346574; x=1733951374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tsf1B3K8ObjY/a5OP+Q/g6OuaEcUeJnWqbbG4D5IXIk=;
        b=nDA6qxJK1BvrXGTSqNffZEdcW6hn01Z1Ebznaz7GjFScVPv0ngdmR/h+JssIs8/ZMG
         H2PkgryJ/L96HV8K5VPOI+NcvGaXK4kJXM0qFdHO6M5cSoe2vrqmX+dXGzYXDkhqOjnt
         bDDFiDJGn+5tTvxE0naDDarFlQkQ77Yq5wsYBWsuvj47G6sScAAMTdm/8jXMJQbl37l7
         cPMeX17EwArzhC/37ywgJTNe+h6RZ6EqsN1mVosEwFzKarPEyWWGztD0e0xp3gFpfQMU
         XXSC0igICXH9tpkzqGVgAQIF8MjGR+9sfEs95uvOSsignuhrDlPzVmMYtz5McGXKoI7J
         RW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733346574; x=1733951374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tsf1B3K8ObjY/a5OP+Q/g6OuaEcUeJnWqbbG4D5IXIk=;
        b=NbwSK3Y7VvgmD4bknpxoX4QqFTZ+jdYDYbcF3JIYy5jcSozGHtRXBYB0558ATQvXVn
         4BRc0BTiPEwjos07SjUHx9yBRzRWxRDdzK5tlqzHdFmldTg0dn/B2ha4mbcIF2nOO88S
         4S8SWg2HvIJaHeET4pz2A+9okVFrMR70XRqlwjj5MVPhsBp2woiC4xo0vIpR4UaKxyKN
         BBB7pI5lxsmCgSFsFe7JZUCIwA5v2QtWdnuqQAEr+ZZWjX8byBSIq1Wwzth0Ox/IQP3D
         YgPKkg+qfsAeyHRCvFPcTEVy5DMMSgrjNsHKYdLFwAgQkDNTf4ntpRQSm8gooOK7WJP7
         CEBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ84z8S7OnhBGpQ4vZaLU6jstRZ6o59GIKE/rQP1XtzQoF2yUPZnIbfamhvWtJFWTMD+VdhSP5KQ4d6rXn@vger.kernel.org, AJvYcCWzAIub2b7VFsytOgQ7HJHipVSpGLT3tgYqqlOnWeIh9+lFY6R/j1PrFDtGKZ50Wi1eEJQADLdlebgmYKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3urysWXblajGWpKDW3Cw197ozq2ajWiEWrQhl+ycGXMhwx5BY
	PbWToAiNXieioipg5atvdw5nnMXlYcisBsdFDD54W2LT+8NgETTW
X-Gm-Gg: ASbGncvsnBfzlJThIL7iIUqTas9ywyE1QQ6r14rJoER4mIf87nCHZHdBewoKfLDxx3b
	x1wQ1pYPvetCHQf0h/VG5nExUAc9mmO2ISm+CrwsziQbS4w8+H+tKfKeovh5bUsKruRu9XTt/aN
	tPQN5HeFO9lSOYsfNI73mRWLXNK0owB79CZae2ekwSpLge/BpsDBFX3t9vkfLAPMI5IxsoSQPw5
	DMshFPjOtSU+N4ACcRj3kZBvLwF6nxj+HjLx94uhvUHkGapNFvra7sx7FeXYjU=
X-Google-Smtp-Source: AGHT+IFHRgetdKevJTYyy/QsuL15/GmOobjg42+ncAiF25wWk/D6c0K0tdZrVedyWkkiLHUVvD/5nw==
X-Received: by 2002:a17:902:e5ca:b0:215:9f5a:a236 with SMTP id d9443c01a7336-215bcfbcebbmr108086945ad.6.1733346573729;
        Wed, 04 Dec 2024 13:09:33 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152191ba31sm116833625ad.110.2024.12.04.13.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 13:09:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 4 Dec 2024 13:09:31 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-serial@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Yang Yingliang <yangyingliang@huawei.com>
Subject: Re: [PATCH 1/1] tty: serial: handle HAS_IOPORT dependencies
Message-ID: <4446d7dc-efb0-4395-8fcb-7177d9e07b5c@roeck-us.net>
References: <38bf3b8b-81c4-42c9-902d-b5719f3881c5@roeck-us.net>
 <3b75b92805648577ed05ff221d0c56e381aa1c7c.camel@linux.ibm.com>
 <472eb22a-dcb1-4fbb-bf2c-a4173706bc7a@app.fastmail.com>
 <27685942-fb62-44c5-86ed-98beb547ffed@roeck-us.net>
 <744920ba-551c-466b-ac5c-2607b81261a0@app.fastmail.com>
 <Z0QtZky8Sr7qUW7v@smile.fi.intel.com>
 <00f5e842-3ee9-4d83-8836-0ff4f703fa3c@app.fastmail.com>
 <Z0RSZ-YD_BozMs1n@smile.fi.intel.com>
 <be43108e-4135-4927-ba58-141836fde6af@app.fastmail.com>
 <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a38025-afae-4bdf-a468-21ae2cd5a7b3@app.fastmail.com>

On Mon, Nov 25, 2024 at 04:59:00PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 25, 2024, at 12:06, Arnd Bergmann wrote:
> > +unsigned int nr_uarts = ARRAY_SIZE(old_serial_port);;
> > +
> 
> Unfortunately, this breaks on non-x86 because of the check
> added in 59cfc45f17d6 ("serial: 8250: Do nothing if nr_uarts=0").
> 
> I still think it's the right idea, but need to unwind further
> to make this possible, and find a different fix for the bug
> from that commit.
> 

I decided to apply the patch below to my fixes branch. It doesn't change
the code, it just gets rid of the warning backtrace.

Guenter

---
From 96c4d1ab237f4a418d17a66c114493273b87468a Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 4 Dec 2024 10:58:41 -0800
Subject: [PATCH] tty: serial: Work around warning backtrace in
 serial8250_set_defaults

Commit 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
triggers warning backtraces on a number of platforms which don't support
IO ports.

WARNING: CPU: 0 PID: 0 at drivers/tty/serial/8250/8250_port.c:470 serial8250_set_defaults+0x148/0x1d8
Unsupported UART type 0

The problem is seen because serial8250_set_defaults() is called for
all members of the serial8250_ports[] array even if that array is
not initialized.

Work around the problem by only displaying the warning if the port
type is not 0 (UPIO_PORT) or if iobase is set for the port.

Fixes: 7c7e6c8924e7 ("tty: serial: handle HAS_IOPORT dependencies")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4d63d80e78a9..649e74e9b52f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -467,7 +467,8 @@ static void set_io_from_upio(struct uart_port *p)
 		break;
 #endif
 	default:
-		WARN(1, "Unsupported UART type %x\n", p->iotype);
+		WARN(p->iotype != UPIO_PORT || p->iobase,
+		     "Unsupported UART type %x\n", p->iotype);
 		p->serial_in = no_serial_in;
 		p->serial_out = no_serial_out;
 	}
-- 
2.45.2

