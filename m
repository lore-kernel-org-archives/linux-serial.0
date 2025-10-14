Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06C2D8764;
	Tue, 14 Oct 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436483; cv=none; b=YR00ZhZdhxGL7k/JE/IBmSnGJOv71Xck9MCrqRQbAPi2rEdoPEXGkeRpznHq7JfmhT8ESZdlHEXEjvUoHitsLfbhwNda8NHv7yvEhPTT6hzH5EehXWCS17aGw81lbdWFYkOyuBV3WKLN7GodBw23B3SVogJc2nLcwuI5sj9rMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436483; c=relaxed/simple;
	bh=SSCBeJ8YaxPzGGnlaYVZUiXTKXZ5yYcoN/AmOZYDRxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elawo8nThXHo093JG7jIzGQQ9sM+buNFvnZSvBsUgcAXdiLGbSXLMvPGPP7aqxnsQ5G09lsQiT2sOJdiD0KFmKVrMk+vDH5QwePFRiG/s67fz63mAJFnDSN+JEGdOmllO1NY6k2iEYkqxUtnZGp1ldOqupIhxxhSYArrrN+nU4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=OhNzZHNs; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OhNzZHNs"
Received: from localhost (unknown [10.10.165.11])
	by mail.ispras.ru (Postfix) with UTF8SMTPSA id D7A304076183;
	Tue, 14 Oct 2025 10:07:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru D7A304076183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1760436471;
	bh=SSCBeJ8YaxPzGGnlaYVZUiXTKXZ5yYcoN/AmOZYDRxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OhNzZHNsBMufwTkKrOIwGeFEPftMV6y7L8BKIBqMJ6Q8Je+fQXwuGaDQLMkRaFfOR
	 iRlSPWRuv3Q30ovuzIQHKyoUWHZ8dYxFVqsqNSsEJebUBLl1YIx9HiWGxl6ZaYw1xN
	 DzmSpc3GdTypCluR/LF9VnaVoiP81VfMduVAhdys=
Date: Tue, 14 Oct 2025 13:07:51 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org, 
	Eddie Huang <eddie.huang@mediatek.com>, Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v2] serial: 8250_mtk: correct max baud rate in
 set_termios() method
Message-ID: <20251014130050-5cdb9e464558d609872d38cc-pchelkin@ispras>
References: <3eb40848-3bec-42ca-845b-c66d4b53cedc@omp.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3eb40848-3bec-42ca-845b-c66d4b53cedc@omp.ru>

On Sun, 12. Oct 20:56, Sergey Shtylyov wrote:
> Mediatek MT798x datasheets (that I was able to get my hands on) claim
> the maximum supported baud rate to be 3 Mbps, while commit 81bb549fdf14
> ("serial: 8250_mtk: support big baud rate.") claimed it to be 4 Mbps --

At least MT7987A datasheet claims to support up to 4 Mbps, so I think 4 Mbps
should be chosen for the upper limit.

+ added the authors of 81bb549fdf14 ("serial: 8250_mtk: support big baud rate.")
to Cc.

--
Fedor
