From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] serial: sirf: fix line over 80 characters style issue
Date: Tue, 09 Sep 2014 10:51:25 +0800
Message-ID: <D034890E.2166F%21cnbao@gmail.com>
References: <20140909023332.GB19075@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36998 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbaIICvk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Sep 2014 22:51:40 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so7025892pad.35
        for <linux-serial@vger.kernel.org>; Mon, 08 Sep 2014 19:51:40 -0700 (PDT)
In-Reply-To: <20140909023332.GB19075@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Barry Song <Barry.Song@csr.com>, linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>



On 14-9-9 =C9=CF=CE=E710:33, "Greg KH" <gregkh@linuxfoundation.org> wro=
te:

>On Tue, Sep 09, 2014 at 10:16:07AM +0800, Barry Song wrote:
>>=20
>>=20
>> On 14-9-9 =C9=CF=CE=E79:33, "Greg KH" <gregkh@linuxfoundation.org> w=
rote:
>>=20
>> >On Tue, Sep 09, 2014 at 08:16:47AM +0800, Barry Song wrote:
>> >>=20
>> >>=20
>> >> On 14-9-9 =C9=CF=CE=E77:15, "Greg KH" <gregkh@linuxfoundation.org=
> wrote:
>> >>=20
>> >> >On Mon, Aug 18, 2014 at 05:32:52PM +0800, Barry Song wrote:
>> >> >> From: Qipan Li <Qipan.Li@csr.com>
>> >> >>=20
>> >> >> According to key customer's requirement, fix "line over 80
>> >> >> characters".
>> >> >
>> >> >Someone is forcing you to fix all upstream kernel.org code for 8=
0
>> >> >columns?  Who?
>> >>=20
>> >> we were asked to fix csr platform codes some days ago. They have =
been
>> >> fixed locally.
>> >
>> >What is "locally"?
>> >
>> >And you really are forced to do foolish cleanups for no reason in
>> >mainline kernel code for no reason?
>>=20
>> "Locally" means the code tree in our local git repo. Nobody asked me=
 to
>> cleanup all mainline codes, the asked changes are for sirf platform
>>codes
>> whose authors are sirf platform engineers.
>>=20
>> >
>> >> You know, the difficulty is maintaining the difference between
>> >> mainline and local codes.
>> >> So I thought this is better if you can merge it.
>> >
>> >I'm not taking stuff that isn't correct.  Or is foolish.  Neither
>>should
>> >you.
>>=20
>> Never. I always think we need to make codes have good readability.
>>=20
>> >
>> >> >Sorry, not going to take this, if your customer blames you, poin=
t
>>them
>> >> >at me.
>> >>=20
>> >> I understand you are very helpful. But pointing them to you will
>> >>actually
>> >> make things worse as I think we have no chance to convince them a=
s we
>> >>have
>> >> tried our best to do that.
>> >> The benefit of this patch is making people happy. But if you are =
not
>> >> happy, I can make myself unhappy to maintain two versions.
>> >
>> >Try fixing the code to look better, your changes were not valid one=
s,
>> >you are quieting some automatic tool checker, you aren't doing the
>> >correct thing and following the "spirit" of the rule here.
>> >
>> >Make the code look cleaner, and I'll be glad to take the change.
>>=20
>> As you said, most old codes looks better with "line over 80 chars", =
so I
>> would like to know what is the way you are happy. Is it fixing all "=
line
>> over 80 chars" with changes following the "spirit", or only splittin=
g
>> those lines which will follow "spirit" better if we split them.
>> If the lines over 80 chars have been good and following the "spirit"=
, do
>> they need to be fixed?
>
>No they do not, the rule is there to make the code readable, don't go
>through gyrations to match the 80 column rule that makes the code less
>readable, as that is counter productive.

We have been doing a checkpatch pre-commit hook in git server for a lon=
g
time. As you know , a basic hook will reject any changes which have
checkpatch issues including "line over 80 chars". In my original
understanding, this depends on the context of codes. So we disabled "th=
e
line over 80 chars" in checkpatch.pl and moved to manual reviews for th=
is.
=46inally, this triggered a quality control mechanism of users and caus=
ed
many fault reports from customers who were doing serious checkpatch.pl.=
 we
were asked to fix the "bad" quality codes. This is the story.
=20
There are still some gaps to make people understand this and finally al=
l
people become happy. But I am still happy to continue to fix the
situation, and your comments will surely help.
I am still happy to take this one as a start to fix what should be fixe=
d.

>
>thanks,
>
>greg k-h

-barry


--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
