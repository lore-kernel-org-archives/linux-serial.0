Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaYtexrN"
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EDD129
	for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:22:51 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-28b0c586c51so229715a91.2
        for <linux-serial@vger.kernel.org>; Thu, 14 Dec 2023 07:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702567371; x=1703172171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcT2Jb1TBj0DcJUl7sM6tUpyzWt4ekggVFEBQkp4qCE=;
        b=HaYtexrNJbGiaDO9zlSIZeh6h74aZvIK+U9xf0Sq+Oep5wgHxBwC4U1we8x5XwUSwY
         Qz0lrqTmLMzoysyXFxkgFuopeliNDMjhoHD7oBhp1gXLKGJ4hV6dQ1soFe50iQhiD/GV
         mDr+C+F77vJPUoI8JGTF/MhlRUVQ6Ff/uwnwkDPdBxmtu5+k/v8M8ock2LiXp24ESrtW
         1bizF1Qjh5sFA+Wc2LK5Zf9NDwDJc/oMq/YRVFfMWSJqJMp/w5YQX5ekj55+IYIDegXN
         j7JDU+ey9gOZw/jF1/SOVJL5MoNvupR4gBy0W8/8TG6FsVJQx++7GnHWAT6cMEtVd7Cy
         C4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567371; x=1703172171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcT2Jb1TBj0DcJUl7sM6tUpyzWt4ekggVFEBQkp4qCE=;
        b=FaNbcpMh18sDh39iPtR2cWo6c7AGE3ZPTjNp36wfVn+3IXe8XzrT16uYcehUay0AIe
         r7wA/9sLraOwRJNihYQjIYvUD4YlqyARafpG+qbztduJE/cFp1ABtZHiM/IbPY2qLVcY
         Re3pBEGf89/sxYlANFtJTH900P02n+WFiwAuj2c4oweyWbVU82ZE33JGFna02dX0f9+k
         IEN7I+autMCzixQ5jEafgxmU2P0GZZQpqucy/oJwvmAcMyJ0DYRsF7kjUfOTLVXyJX/K
         RujVEbD1tQP1T9b98hz2tl/MAkV6yp1aJrL4H94GnFHySqECCPn342IgQ+8Sz79vpMth
         YxRQ==
X-Gm-Message-State: AOJu0YzjZzvWP3Ztvu71n7qX7J4nK6UqysMkZdcsY8dVjKgP/GZKtjl+
	0vf8XQviFFz+qJTcJW1agRnrKCPfgFu6sJID6FWOtQ==
X-Google-Smtp-Source: AGHT+IGg/odB2Osxk9lczN4UnKuRrAxLwMC4GTU+Il1sBDYBfVUA0edf/1fZr1ZpXwv3dxbCvs+tLYcBum3fRFhMJHU=
X-Received: by 2002:a17:90a:590e:b0:286:55f1:5257 with SMTP id
 k14-20020a17090a590e00b0028655f15257mr4847377pji.17.1702567371411; Thu, 14
 Dec 2023 07:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-2-tudor.ambarus@linaro.org> <CAPLW+4kr=aVjuqGz3ps5f6EzM+QASTFEoB57g+fR7jKH0s+1Zw@mail.gmail.com>
 <0d3ae184-5ded-42ab-97cf-13bbb296083a@linaro.org>
In-Reply-To: <0d3ae184-5ded-42ab-97cf-13bbb296083a@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 14 Dec 2023 09:22:40 -0600
Message-ID: <CAPLW+4mpV0cy32MPS72-z=WYTZusnS7uTO7fbmOruVjAvcoBeA@mail.gmail.com>
Subject: Re: [PATCH 01/13] dt-bindings: clock: google,gs101: fix CMU_TOP gate
 clock names
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peter.griffin@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
	conor+dt@kernel.org, andi.shyti@kernel.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, catalin.marinas@arm.com, 
	will@kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, arnd@arndb.de, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:16=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
.org> wrote:
>
>
>
> On 12/14/23 15:07, Sam Protsenko wrote:
> > On Thu, Dec 14, 2023 at 4:52=E2=80=AFAM Tudor Ambarus <tudor.ambarus@li=
naro.org> wrote:
> >>
> >> The gs101 clock names are derived from the clock register names under
> >> some certain rules. In particular, for the gate clocks the following i=
s
> >> documented and expected in the gs101 clock driver:
> >>
> >>   Replace CLK_CON_GAT_CLKCMU      with CLK_GOUT_CMU and gout_cmu
> >>   Replace CLK_CON_GAT_GATE_CLKCMU with CLK_GOUT_CMU and gout_cmu
> >>
> >>   For gates remove _UID _BLK _IPCLKPORT and _RSTNSYNC
> >>
> >
> > Doesn't it break existing gs101 device tree?
>
> No, compilation went fine at this point. The TOP gates are not used in
> the device tree at this point. And since the bindings patch was just
> applied I think we should fix it, so that we avoid name clashes as
> described below (I found a clash with a gate from PERIC0).
>

Ok, in that case feel free to add:

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

> >
> >> The CMU TOP gate clock names missed to include the required "CMU"
> >> differentiator which will cause name collisions with the gate clock na=
mes
> >> of other clock units. Fix the TOP gate clock names and include "CMU" i=
n
> >> their name.
> >>
> >> Fixes: 0a910f160638 ("dt-bindings: clock: Add Google gs101 clock manag=
ement unit bindings")
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> >> ---
> >
> > (snip)
>
> Thanks for the review!
> ta
