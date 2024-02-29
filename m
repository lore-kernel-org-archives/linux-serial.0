Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC274C00
	for <linux-serial@vger.kernel.org>; Thu, 29 Feb 2024 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244660; cv=none; b=pBCeF1LDeI8KOaHBzPX0tqi6J9bLmwXUsfkbPK10gRXD49/ceYHr2c+DigKT64LLRNd6yUqE/thfN0BoDGqv2JMsgHyp3/9gK5o8GptjR2O+weT71fCAN+3zvu/J/NUi7J6EKFfzh/HYx1bfxOFiv3km1Z5GH6Zbw0lfv4QXcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244660; c=relaxed/simple;
	bh=xvCFb69gT8fom4sva1sehd2q73DRQxqz73k+Hv9pKNw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Lw3tB5JmRPpt9I8SZzdYdYIhL6TGefNx+byDGS92VN7S5td4+LzHMDKamv61MD8PLIRock06Pq0+j0f4K7yepANKOdyg5phbvpPrqbijPpV4is9lhZHefT8ejv/LaDrKgvk59R/yqCGIhztXwrn6jdmfmX1meeM0CGBBFnUMHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VosU1Hkj; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=ut4qVGe5; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VosU1Hkj";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ut4qVGe5"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EAADD1E73BF;
	Thu, 29 Feb 2024 17:10:57 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=xvCFb69gT8fom4sva1sehd2q73DRQxqz73k+Hv
	9pKNw=; b=VosU1Hkjz8Bkm00v3WT4kwV4sL6v5B2ijc5apKsgGgxypOydlqDckQ
	ZhEd3N2r1NLA6bVCxeNmdEM+LRUuAGcgi1rQ3yd3Z519+q5TJwuk94uTjxcnwXLZ
	g8sYMGY6C4UCj1sw72zP1lNzOtAtSfAt3xiYYlwqdzIZ9pfmcUCYg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E35FA1E73BE;
	Thu, 29 Feb 2024 17:10:57 -0500 (EST)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=xvCFb69gT8fom4sva1sehd2q73DRQxqz73k+Hv9pKNw=; b=ut4qVGe5WUPIsgRWC43OmxHrIEqb/IkyTqeYvBXDks0vGcWssMORAPCLp7e1cj/49i6/S7aaMcnoOeXWCBkxkwfQWFhpX7gQuuvuVvjesdzORbMgADMk8lS2qJCokPMID8SOerObvsmEbhD7E2r7Z1jWAAco7VTSU6ORGwCshpI=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 628441E73BD;
	Thu, 29 Feb 2024 17:10:57 -0500 (EST)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 4327AB8787E;
	Thu, 29 Feb 2024 17:10:56 -0500 (EST)
Date: Thu, 29 Feb 2024 17:10:56 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: Re: [PATCH] vt: fix unicode buffer corruption when deleting
 characters
In-Reply-To: <2024022936-chloride-concert-12a6@gregkh>
Message-ID: <3840o476-6p58-q897-101r-34n723p16oo1@syhkavp.arg>
References: <88n6qo5r-2986-r273-9n4p-pr77q314727r@syhkavp.arg> <2024022936-chloride-concert-12a6@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 69E716C2-D74F-11EE-B331-25B3960A682E-78420484!pb-smtp2.pobox.com

On Thu, 29 Feb 2024, Greg Kroah-Hartman wrote:

> On Thu, Feb 29, 2024 at 04:05:51PM -0500, Nicolas Pitre wrote:
> > This is the same issue that was fixed for the VGA text buffer in
> > commit 39cdb68c64d8 ("vt: fix memory overlapping when deleting chars
> > in the buffer"). The cure is also the same.
> 
> Please spell out what the "cure" is here, so we don't have to do and
> look up another commit somewhere else :)

This is an obvious single-line fix. Or, are people only reviewing commit 
logs now?  ;-)

Revised commit log coming.


Nicolas
