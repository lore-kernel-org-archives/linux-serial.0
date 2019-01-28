From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: Re: [PATCH 1/2] Serial: Ingenic: Add support for the X1000.
Date: Mon, 28 Jan 2019 20:44:47 +0800
Message-ID: <5C4EF93F.9080706@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548667176-119830-2-git-send-email-zhouyanjie@zoho.com>
 <20190128093059.GA31657@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128093059.GA31657@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, jslaby@suse.com, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
List-Id: linux-serial@vger.kernel.org

My fault, I will fix these in v2.

On 2019=E5=B9=B401=E6=9C=8828=E6=97=A5 17:30, Greg KH wrote:
> On Mon, Jan 28, 2019 at 05:19:35PM +0800, Zhou Yanjie wrote:
>> Add support for probing the 8250_ingenic driver on the
>> X1000 Soc from Ingenic.
>>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>   drivers/tty/serial/8250/8250_ingenic.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
> You sent two different patches with the same subject: line, yet they did
> totally different things.
>
> Please fix this up and resend with a better set of subject lines.
>
> thanks,
>
> greg k-h
