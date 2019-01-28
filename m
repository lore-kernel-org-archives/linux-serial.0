From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: Re: [PATCH v2 1/2] Serial: Ingenic: Add X1000 suppor for the UART
 driver.
Date: Tue, 29 Jan 2019 00:45:00 +0800
Message-ID: <5C4F318C.20505@zoho.com>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-1-git-send-email-zhouyanjie@zoho.com>
 <1548683821-120924-2-git-send-email-zhouyanjie@zoho.com>
 <20190128162245.GA25853@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128162245.GA25853@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, jslaby@suse.com, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
List-Id: linux-serial@vger.kernel.org

I am very sorry, I understood wrong before.

On 2019=E5=B9=B401=E6=9C=8829=E6=97=A5 00:22, Greg KH wrote:
> On Mon, Jan 28, 2019 at 09:57:00PM +0800, Zhou Yanjie wrote:
>> Add support for probing the 8250_ingenic driver on the
>> X1000 Soc from Ingenic.
>>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>   drivers/tty/serial/8250/8250_ingenic.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
> Your subject lines are still identical for both patches :(
