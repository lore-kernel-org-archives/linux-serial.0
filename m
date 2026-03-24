Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E87B361641;
	Tue, 24 Mar 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774339119; cv=none; b=YW8iUAZZnNJL3b5HekxodcexpWUvXeIdE0SnuZ8dD9ORi8dkHR+5HwaYZlorLwNEdx+fdx+a5nwP3pcTOQAZl1NagbEQei3d9dxNm51WQ8tPjquYJsKDw8MnpK8mscwzdA+7EiNIrxoVdAD8/Cs0YuqOrcGl/NBuhkxoOjXQcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774339119; c=relaxed/simple;
	bh=E+devhyf9IBWaUXNi/p4XMjZeYP3OaMpOXno4la6WrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwx4D2F6/h8tiFiarTKqPowri5GliAFamTF+oxRsLKqkKw5EQd2MP5q3Wc/ZLhPs2s9W7dJFgEK7sEyMcjD2QZnOZLTRvsczcWL062dobzjgmioTmp+nuLlcwzP5HbS9TLtlZ67XuIHn6n7m4+2sJprhxRsxIljHf7Ao6vgqjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=01CJnKZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="01CJnKZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11451C2BC9E;
	Tue, 24 Mar 2026 07:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774339118;
	bh=E+devhyf9IBWaUXNi/p4XMjZeYP3OaMpOXno4la6WrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=01CJnKZWmVm9hOCxsByxCGITUNgJJf7mlBVaCZSReqbWYJyB1yH1m0yHJFmNfM2hJ
	 M2V15EIv0mvwaa1OMTnRxUV59ka36szHwS1qylnysTzvZ1725rohUs+vMROEnVujad
	 B0YN3zO4EIvIB4fAYwm7GQCvhYVlc4N6M8k+G1wA=
Date: Tue, 24 Mar 2026 08:58:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: Kexin Sun <kexinsun@smail.nju.edu.cn>, jirislaby@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg
Subject: Re: [PATCH v2] tty: atmel_serial: update outdated reference to
 atmel_tasklet_func()
Message-ID: <2026032400-trimming-amused-b147@gregkh>
References: <3bd295ee-1607-49db-a12e-5a4d4fc81c5c@bootlin.com>
 <20260324024857.3244-1-kexinsun@smail.nju.edu.cn>
 <89bc9543-9fcb-4563-b6ff-01b186231ce8@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89bc9543-9fcb-4563-b6ff-01b186231ce8@bootlin.com>

On Tue, Mar 24, 2026 at 08:08:40AM +0100, Richard GENOUD wrote:
> Le 24/03/2026 à 03:48, Kexin Sun a écrit :
> > The modem-status comparison that used irq_status_prev was
> > moved from atmel_tasklet_func() into atmel_handle_status() in
> > commit d033e82db9a5 ("tty/serial: at91: handle IRQ status
> > more safely").  Update the comment accordingly.
> Double space here, but I don't think it's necessary to send another
> iteration for that.

Double spaces are the "real way", so this is all good :)

