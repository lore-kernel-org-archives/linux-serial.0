Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449622;
	b=x9jXC8/5hBRbiw3VMLG13N9PUUyCo6PKfcqxrSoxVyX9VvI2qDBitgmO5XZehqkO/vRK
	 ai9lao3uUVRkPDMFXFaYGJ/oAIngmZg/KV9cpc5hm5j8+GRUNw6N0ZGEGVxX2ChFhCIaN
	 ChGwJ6NB3zHfoiEIGREUNQsyZojL2n09IesRGye8+ympMlQGSwAFziqwahcP67LpeeedQ
	 wpEtEk5zPjsLO764KmRlcATttT9vvo/Um2RHRRG7lTSniZejjcL5WAp8KqkI4jGtMo6HL
	 oShtyZkoHb0+eT5LM2LOP7Ynz+WKFnhT6hxDLTO9YALHhi0WaDzIP1vC9Isy+1kmqZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449622;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hL2POtwbIEe+4GWOCdTadB+dlLerSVJ0joNIPqXJqYs=;
	b=HF15iwyqOE/otQeaOOWnuMMWsisv0xyiLjDbJnZuS9OnYtTvIzXcPo1tP1W4AEG3cF21
	 sBtAP7n59OY1b0TzTddExum9wPlcgSyXe7aztZ9IBOeDa0wAjOQhS49roy/nZnBmt2b1x
	 9DaFMd4xJ4s3JFZH7blDoszAAUqB5v5NxJWDw2/oVzoXTjfPxDTWdpIqewqqNt3G19FzD
	 0qGlX5zkCTYWMw5R5xENjucE3F2Tm9+XbwYIl+Lbm1kIjX4sssOqBQRMX10pOu3kogv65
	 AD9vnzAx27Aaft0AA/duhP8XyCE11ZaZXoDTUt+sYV1TArNIwcH6XdKH8pGobrq2OlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="g/Qu7+pv";
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB16606A31C;
	Thu, 12 Nov 2026 02:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=g/Qu7+pv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=g/Qu7+pv/7Dri6YXRy8F6sJgfgt8+bT93rGqrYfBwLwasrx3VXXCz+cLCy7F+jePk36UNkdCfCSd4
	 E2aQcnJCrCJdhFJKjChFQG/uPjJs1LW6rUio/Mm0LxDKVoJVaiciL6GkJEpVqHjsUDk9BQUo3zBShJ
	 Fw05TMjn2iVKUrsQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af520d170e-dd134;
	Thu, 12 Nov 2026 10:13:37 +0800 (CST)
X-RM-TRANSID:2ee76af520d170e-dd134
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af520cf9df-eee49;
	Thu, 12 Nov 2026 10:13:36 +0800 (CST)
X-RM-TRANSID:2ee96af520cf9df-eee49
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock frequency
Date: Thu, 12 Nov 2026 10:13:34 +0800
Message-ID: <20261112021335.1774-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <2026111106-drowsily-dexterity-bddd@gregkh>
References: <2026111106-drowsily-dexterity-bddd@gregkh>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

sorry for the missing context.  The patch I was pinging is:

  serial: sc16is7xx: Fix clock leak on invalid clock frequency
  https://lore.kernel.org/all/20261030085508.1882-1-laixiangwu@cmss.chinamobile.com/

sc16is7xx_probe() enables the clock with clk_prepare_enable() early
in the probe path.  If the clock frequency cannot be determined
(neither from the clock itself, nor from the "clock-frequency"
property or platform data), the driver bails out with -EINVAL
without disabling the clock again, while the later error paths of
the probe already jump to the out_clk label.  The patch makes this
error path jump to out_clk as well, so the clock is disabled like
on the other error paths.

It was submitted on Oct 30.  Is there anything blocking it, or does
it just need more time?

Best regards,
Xiangwu Lai


