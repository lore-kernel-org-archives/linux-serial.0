Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4B5013BC
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897978; cv=none; b=dBg0SqLp4moWCkK0kfsiveYwETsOeVd8iMCeRCZnhTznhQoLuYwlsUBFFQYal+baAZ+5ilMUHX+yjKPPI//m13kH246lvoRDN8oPrp8qEOn/Mba5TJAR7iU9da1pfw4EPPSO3GO/qz8IzTLP5A3LSaHAHyelMhiegvCXJjEBNbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897978; c=relaxed/simple;
	bh=SENrlduSOY1c5wO4sb1+YYTgTOXpB4xleewXcNp3+n8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uQpZAi205vCg1W5aectf5I3sBsPENVRn2DrgDfm4fCgQefO7O/ETUgX0onc6bojUS8gOAbmqYmT4RI12+8iIYASvQAYh+/xm+LxiMbnolYsvGreyUYTRoHe6NOhMnPzBfkHQFtQ/yVzZsq0T0vhCJisSVKT74BLYoTNFY4NIcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gk5LS8Rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gk5LS8Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED711F000FF;
	Tue, 13 Oct 2026 13:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791897977;
	bh=0dgn1IgVBCHCKt6iGJZY6MJHn25BoPh18hR+jbSYdAQ=;
	h=Date:From:To:Subject;
	b=gk5LS8RdPWjRx0u0i1p1IkWm63ktBzxPMQLu2xCwQ0GRWb/+mpEHdhyt6NF5iDvq8
	 T9+VBfKP798AuMZbi310mKX7DtMmpPRNhquDY9uqr89cjGwh0kyiqaDSz1XLVKtWsZ
	 0xsMr8obxn+7hBk5UzgAYFWg6HFu8xt77K+e1Qc8=
Date: Tue, 13 Oct 2026 15:26:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-serial@vger.kernel.org
Subject: finally caught up on linux-serial submitted patches
Message-ID: <2026101337-euphemism-cake-2eec@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I've now caught up on all pending linux-serial@vger submitted patches in
my review queue.  If I've missed something, assume it's lost (or sashiko
found problems with it), and refresh it and resend.

thanks,

greg k-h
