Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1B385508;
	Tue, 21 Apr 2026 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776753844; cv=none; b=B5pgCFQ8YD0UyB3QF5iG9Vm0TlJ25gb+c+gsLLnD/YUZCODlsigIhior7qmsVMZWJagDZN2p2a60iyg7lHgg4XxxpvAKyR4iyHRWIx+8JKeKWOCF5+Fny8rJwqFsOtVqgZTCeYbZW7LPmQbHpAPdIh5HmfVVtNmPTmmSKmsJAYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776753844; c=relaxed/simple;
	bh=bZqL/b9Rb73MuJK65SCCPJWub6r6O5yTFuea0ynWzbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0JW2swzHA8JXTB47sGWrnIdv1nI8WlkO7X99G6CECZnTcIjf9e7CQ6gEwE7Sn0vP2YPh6RmwEjHP6fjCCLyaVQ0lf10yVgqpuS0K73HBGEs0G6cEitGAyzHpU7q6I7BSEbrEdNCf+ic8p53UD+OwKGatQM+cc/pIFxo3raj2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SGBEU9MH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SGBEU9MH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB912C2BCB0;
	Tue, 21 Apr 2026 06:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776753844;
	bh=bZqL/b9Rb73MuJK65SCCPJWub6r6O5yTFuea0ynWzbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SGBEU9MHiO2QYhKD5SH+Ung3mKH77oeVdoTfinvsbAtHD8+cmDo927on0ZxYrP9T7
	 UzdfRedVAdFtQY2WBk5mpipSUp1oZFB7FMQCkUPMpPvl4IQZNQ54TSCUPiD9/mQKsd
	 WrV5E5YSGzcZPId1a4Ql/XFEbpncH8XObnd8ddbs=
Date: Tue, 21 Apr 2026 08:43:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: jirislaby@kernel.org, geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com, wsa+renesas@sang-engineering.com,
	thierry.bultel.yh@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	zhongling0719@126.com, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] serial: sh-sci: fix memory region release in error
 path
Message-ID: <2026042111-dispense-rupture-fad1@gregkh>
References: <20260421063819.715295-1-zenghongling@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421063819.715295-1-zenghongling@kylinos.cn>

On Tue, Apr 21, 2026 at 02:38:19PM +0800, Hongling Zeng wrote:
> From: zenghongling <zenghongling@kylinos.cn>

This needs to match the name you used in your signed-off-by: line.

thanks,

greg k-h
