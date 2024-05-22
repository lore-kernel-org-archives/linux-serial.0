Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106861E86A
	for <linux-serial@vger.kernel.org>; Wed, 22 May 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381568; cv=none; b=fYJpu9yJA8IA0edxC8RJZ53WdrO0GoaFy0v7Qr8zEcQC5cpLKjXJvucbALkD3uO1jILX7qTlkVJT/8FzZdY4NapmbvYgR6nrhridiiaxbtugoMY23WPKK7v4oseb9WDmUrpBihb5gh4y2Me8oTH5gc+9emK5jRBg+uqf/CqDIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381568; c=relaxed/simple;
	bh=vh0WxDgfQgMWm14h3/iUhT/VwFR71d9hn3Hu6cnsAD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwwlp1Lm2D5dIrZ1y1AhLwDyHKMj4USeRrIMakrXrg/ECpu7ML6MN3i3nb4xD5bhwz/+DdiXzWpwWoV+EsmfY5FLQCPoh/+ZceB9Tnjb0cSYtP24VJjeXwT2ApEAfhg1dfR9x80f+LdB+4fLONxXMmnMlOQ3EuwKwWcQR0bOAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Yc+m7sr8; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Yc+m7sr8"
X-Envelope-To: gregkh@linuxfoundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716381565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ghbu8+ZnCK07q7xTXnO+Z2JVcCZZP4HpKAs3rCGet+0=;
	b=Yc+m7sr8n7pgCQ2MFRAZVPsrMatTRsaYrXWoyoJj2YPKREJOq31owu0244arVSzc/SWa4G
	apMJbUhDrA9AXczH0EeVCBSVWCkyZhN/u3vcA7R9lwmeajcxB4yf7xm7/+206jhZl4SCPw
	As1WHCwGhZC5FUshEdI78V0oHN9rjg8=
X-Envelope-To: kuba@kernel.org
X-Envelope-To: jirislaby@kernel.org
X-Envelope-To: jonathan.lemon@gmail.com
X-Envelope-To: linux-serial@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
Message-ID: <cf74065c-7b68-48d8-b1af-b18ab413f732@linux.dev>
Date: Wed, 22 May 2024 13:39:21 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 net] ptp: ocp: adjust serial port symlink creation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240510110405.15115-1-vadim.fedorenko@linux.dev>
 <2024051046-decimeter-devotee-076a@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <2024051046-decimeter-devotee-076a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/05/2024 12:13, Greg Kroah-Hartman wrote:
> On Fri, May 10, 2024 at 11:04:05AM +0000, Vadim Fedorenko wrote:
>> The commit b286f4e87e32 ("serial: core: Move tty and serdev to be children
>> of serial core port device") changed the hierarchy of serial port devices
>> and device_find_child_by_name cannot find ttyS* devices because they are
>> no longer directly attached. Add some logic to restore symlinks creation
>> to the driver for OCP TimeCard.
>>
>> Fixes: b286f4e87e32 ("serial: core: Move tty and serdev to be children of serial core port device")
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>> v2:
>>   add serial/8250 maintainers
>> ---
>>   drivers/ptp/ptp_ocp.c | 30 +++++++++++++++++++++---------
>>   1 file changed, 21 insertions(+), 9 deletions(-)
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>    older released kernel, yet you do not have a cc: stable line in the
>    signed-off-by area at all, which means that the patch will not be
>    applied to any older kernel releases.  To properly fix this, please
>    follow the documented rules in the
>    Documentation/process/stable-kernel-rules.rst file for how to resolve
>    this.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.

Hi Greg!

Just gentle ping, I'm still looking for better solution for serial
device lookup in TimeCard driver.

Thanks,
Vadim

