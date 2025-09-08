Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B552E2EFC;
	Mon,  8 Sep 2025 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316978; cv=none; b=FfqIG4uGR9tqjrXw4lLpffcrYOrC8Ivv+Vthuh9BE/ij2zwyGfH5wLIUMCppJ2YHiwBPvSgw1XbxN24vCyBylWyj/ax54wXdcX6kM5Mbx23XYwnCfYIkwfUBdpvOIVvMClAVYQWR35COtqwfQ6h2yWBp8YUopMlN6Idel/EATQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316978; c=relaxed/simple;
	bh=gyazbsxG6Gq+/qGboWGhnRTaMRG1xYrWLEuvVFzuew4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV+R5ySbcvPr5UDZRe9tdSv+Mg+K+yYrzGLs/EmWBXOzcmKv7fCZ4fHzUDCMFzWNtDToVm79KZh7Q7MlAB/JsBMBycwdPqF5q32VPn8Db8IriVUy5/dyX2bua71IBSB+4V44yoyq4I6SHagVu4WIExfkvlFtaxaep1zbptoq2vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cKzK56zJKzKHMXN;
	Mon,  8 Sep 2025 15:36:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 143001A12B1;
	Mon,  8 Sep 2025 15:36:10 +0800 (CST)
Received: from [10.174.176.88] (unknown [10.174.176.88])
	by APP4 (Coremail) with SMTP id gCh0CgCn8Y1mh75oNiApBw--.63375S3;
	Mon, 08 Sep 2025 15:36:07 +0800 (CST)
Message-ID: <94b30154-b7c9-436e-bae8-6120bd6d1b78@huaweicloud.com>
Date: Mon, 8 Sep 2025 15:36:06 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] tty/vt: Add missing return value for VT_RESIZE in
 vt_ioctl()
To: Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
 npitre@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 yangerkun@huawei.com
References: <20250904023955.3892120-1-wozizhi@huaweicloud.com>
 <8b01bd0a-e8b3-4e9a-86fb-3005ff5351fd@kernel.org>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <8b01bd0a-e8b3-4e9a-86fb-3005ff5351fd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn8Y1mh75oNiApBw--.63375S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4DArWkKF15XFW5urWktFb_yoW8tFWkpr
	s5G3s8CryDKFyxGr1Utw1UZa40qr18Ka17tr1UJ3W3Xrn8Ary29r15WFy2gF1DAr4xKw17
	tr4q9r10v3WDJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/



在 2025/9/8 14:50, Jiri Slaby 写道:
> On 04. 09. 25, 4:39, Zizhi Wo wrote:
>> In vt_ioctl(), the handler for VT_RESIZE always returns 0, which prevents
>> users from detecting errors. Add the missing return value so that errors
>> can be properly reported to users like vt_resizex().
>>
>> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
>> ---
>>   drivers/tty/vt/vt_ioctl.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
>> index c9f11c4bd9fe..28993a3d0acb 100644
>> --- a/drivers/tty/vt/vt_ioctl.c
>> +++ b/drivers/tty/vt/vt_ioctl.c
>> @@ -908,7 +908,9 @@ int vt_ioctl(struct tty_struct *tty,
>>               if (vc) {
>>                   /* FIXME: review v tty lock */
>> -                __vc_resize(vc_cons[i].d, cc, ll, true);
>> +                ret = __vc_resize(vc_cons[i].d, cc, ll, true);
>> +                if (ret)
>> +                    return ret;
> 
> The change looks good per se. But I wonder if userspace users do handle 
> or ignore errors? Have you checked any of them?
> 
> thanks,

Thanks for the question.

In fact, I discovered this while reproducing a syzkaller issue[1]
myself. When I executed ioctl(tty_fd, KDFONTOP, &op) (setting the width
and height fields to some extremely unreasonable values), there was no
error reported, but the expected result did not occur—that is, the size
was not actually changed.

So, I looked into the code and found that width and height must meet
certain criteria and constraints. However, because the ioctl call here
did not check the return value of __vc_resize(), I was unable to quickly
identify this issue.

I haven’t checked whether other userspace code would check this return
value. However, even if some userspace programs currently ignore the
return value, I think it's still beneficial for the kernel to return
accurate error codes? This makes debugging easier and allows future
tools or developers to rely on correct behavior.

[1] https://lore.kernel.org/all/20250905024340.337521-1-
wozizhi@huaweicloud.com/

Thanks,
Zizhi Wo

