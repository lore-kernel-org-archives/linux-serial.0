Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085B433A032;
	Sun, 20 Sep 2026 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882396; cv=none; b=Lp9SwW3uzdeU9BYDuGEzBv3DWnKkCPz/1XEOyshvD/eoPwhA5u50u8VG5M9INmBbVQST2O11+ITVSBx66MEXBJRajhUUhIrfUc4Znr0tOlw0Rr34fB3smuNtAoy78EEgigVDx8yvXGz153B0fB4mg9uiL4OLqJVVgWnWsESSdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882396; c=relaxed/simple;
	bh=XoI4edhgGdJwKp1braSraZxTUwY/6MF2IB/Zf9rijRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxSTCijKYxK5ENrFhdBVgHYgaoQ1hCJL4/QiHL6IRvW+IfN7+k0FnMfJUqvNE4Xd3Tt1gsZqQdxNOuV9WnfB4vLIgTvoD8gtUX8YJDaDHxFQhTZRfrBHU6iDhPFFenAPcaCnQ3ooe8KRvPim3osMiRzR571O3saiuTm8hzvRVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XaWpLJLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XaWpLJLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AEC1F000FF;
	Sun, 20 Sep 2026 05:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789882394;
	bh=Y/i6a0OEEE7rLVyx44EXUL7JzU2Uku6WGdpxRD85biI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XaWpLJLy0a/h3ad/wcbTxJ+mFlLR6vlaleygTdzy6uPTyi9QdTrxyT7iOltfFvCU6
	 ht1wbFbo0wfVrgRlAAvb3I4AOUDqaHxgSXlAKJdClnyGWdn0NooHTmkzP4vpKcdvhZ
	 CfU64p36eh15Ae99LBEtk0aY56Gpcx4DAj8WQwg4=
Date: Sun, 20 Sep 2026 06:31:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, john.ogness@linutronix.de,
	linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] serial: fix 8250 hash_mutex race and
 uart_get_baud_rate() divide-by-zero
Message-ID: <2026092054-dish-ship-2841@gregkh>
References: <20260919222627.3797854-1-benquike@gmail.com>
 <2026092001-judicial-coherence-46a5@gregkh>
 <CAKpmkkV+Gk11x0wCbT1dK8FDraaCb0q=ALS+Tnj0wM+EcMt-SA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKpmkkV+Gk11x0wCbT1dK8FDraaCb0q=ALS+Tnj0wM+EcMt-SA@mail.gmail.com>

On Sat, Sep 19, 2026 at 10:20:48PM -0700, Hui Peng wrote:
> You are right, I apologize for that.  I have stopped submitting new ones,
> working on the submitted ones.

Please fix your email client to not top-post or send html email, as that
is rejected from the mailing lists :(

thanks,

greg k-h
