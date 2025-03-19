Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2F251788;
	Wed, 19 Mar 2025 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383288; cv=none; b=Q/h7vLBiKjrqD4rsvd1yQve9KsYLWpu7qCZ148UKLpcli1Otjee1no8701iEcAsb9xHb9l7QT2E4MbdTvNsSAsi1jWPz69Mo26zDnnNIl4dyOrWpPwLsVkYyCXP93Rm31Zy/Ks+z4A0Ogg9M5VFxGlkWcZqzsqJpCkK1YpNS0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383288; c=relaxed/simple;
	bh=cTojPu+/tzVZonXBixc/OicuUZ+RrypjBB0rEAbJXJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRBMcqoBJVoeIzB/6z6Y7KNykW5ugfoGG2t1mOL6sm96v9+7PJhhikEkYvu8CKlYlZPvFOU6ch6BqVAkEtlX/IgWrcv/J2gVnWJ6slLF/iKrVhvncPPsXv94yO8HHjCFVa2Z4GGD9ijCJfKojVeszAbr7vjE6wJeHCTck/RNI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X0m2/zJU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X0m2/zJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C73EC4CEE9;
	Wed, 19 Mar 2025 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742383287;
	bh=cTojPu+/tzVZonXBixc/OicuUZ+RrypjBB0rEAbJXJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0m2/zJUUvpVeW+WAJYWGE6zFcHfLxt9xVogLJBN85wJ+eIZSoVLsCY6p0JIcbi45
	 AvO5kInR5006e2J/8O+hALAR6cXPUXlGAbcjoQLF8NVBJXGSN7A7FUt0KaPGl7n/M/
	 c21ghuXoXh0qJr69m2L2FIwp/k9qhtkSY8bB2lJw=
Date: Wed, 19 Mar 2025 04:20:08 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250_dma: terminate correct DMA in tx_dma_flush()
Message-ID: <2025031900-junkyard-crane-4c93@gregkh>
References: <20250224121831.1429323-1-jkeeping@inmusicbrands.com>
 <tencent_7FB378712CE341FE55666DAD@qq.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7FB378712CE341FE55666DAD@qq.com>

On Wed, Mar 19, 2025 at 02:14:40PM +0800, Wentao Guan wrote:
> Ping?

Context-less pings help no one :(
