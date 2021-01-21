Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5823EC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 19:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0926F23A53
	for <linux-serial@archiver.kernel.org>; Thu, 21 Jan 2021 19:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbhAUStA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Jan 2021 13:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbhAUSnF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Jan 2021 13:43:05 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED1CC06174A
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 10:42:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e7so3647138ljg.10
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 10:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxxRmOWHFxsuUmxyFSFtFZ8g0U1sHGWc8WvpI89kpKc=;
        b=gl/O090/Wgo+WqvhIOif70J33msLyLPf5lp12lBldbaVxFM2n2+Oy0rgGO1VIMErVq
         3UwtjioeLdJpUzw/e6yckLG5H890DjWnPAFYPYDvpi1YF50zJV/qf93ZxwWklEHcCotO
         O8rmY8fj/WNbx3AWWRhF01g52Mx1SJTCxrxko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxxRmOWHFxsuUmxyFSFtFZ8g0U1sHGWc8WvpI89kpKc=;
        b=C0ssw5POTLL7B7qpICgKRFkTVxHoAiMq5fkmqjypm/WlWepTyohFHXFsW5+R4Sy04X
         HRHrFrTcgU6nyantgxw0eG2nyRUyLd4tFt/X7KtKTkcXTTqAAOKTOvefwrcQcAwH3VJN
         fwEL1DqyLdjvQqImJDS0vEk7/ABhyiEyG2NHSk1VfG2CorgtzCxCQtaVpQaT+k4HLrdE
         NcRlvrSIdBSGqx1622krSa6RPVTVkkkgOz/71/ztYQO4AsRvPdBQgRf8QA/8aaoo1Xbg
         GTqFhNHZ6kHu9SuVqJ9N/ok8F7oGxJQBdDd+suLqPdX/IH4sjrE49X2DUUFHgdD3yrli
         IBeQ==
X-Gm-Message-State: AOAM530gOI+lPagN2lSfSILU4JTTm9YgSuaO++/sbN48/f/b5RFMPrz3
        jDfHoi2UwEBYbD098hQoIgptRB3pYtLTzA==
X-Google-Smtp-Source: ABdhPJyz4fsqR9cQjjIYIz6pSfhK88rXooJIiqGXIzjMUFSs7tDZO0YEXj4+9APwhEiH4riAKUpNHQ==
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr48124ljp.97.1611254542922;
        Thu, 21 Jan 2021 10:42:22 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u15sm607478lfm.61.2021.01.21.10.42.20
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 10:42:20 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id u11so3622658ljo.13
        for <linux-serial@vger.kernel.org>; Thu, 21 Jan 2021 10:42:20 -0800 (PST)
X-Received: by 2002:a2e:720d:: with SMTP id n13mr366861ljc.220.1611254540130;
 Thu, 21 Jan 2021 10:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20210121090020.3147058-1-gregkh@linuxfoundation.org>
 <f4c72a0a-25e6-5c7a-559b-6d3b7c930100@kernel.org> <CAHk-=whE3fmgWx+aNvC6qkNqJtWPre3dVnv-_qYj7GaWnW72Vg@mail.gmail.com>
 <YAnAfNcE8Bw95+SV@kroah.com>
In-Reply-To: <YAnAfNcE8Bw95+SV@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 21 Jan 2021 10:42:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
Message-ID: <CAHk-=wh+-rGsa=xruEWdg_fJViFG8rN9bpLrfLz=_yBYh2tBhA@mail.gmail.com>
Subject: Re: [PATCH 1/6] tty: implement write_iter
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oliver Giles <ohw.giles@gmail.com>,
        Robert Karszniewicz <r.karszniewicz@phytec.de>
Content-Type: multipart/mixed; boundary="000000000000822f5305b96d6e07"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--000000000000822f5305b96d6e07
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 21, 2021 at 9:57 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Incremental patches please as these are already in my public branches
> and I would have to revert them and add new ones but that's messy, so
> fixes on top is fine.

Ok. And since I think you put that first tty_write conversion patch in
a different branch from the tty_read one, I did the fixup patches for
the two as separate patches, even though they really just do the exact
same thing.

So here's three patches: the two fixups for the hung_up_tty case, and
the EOVERFLOW error case that Jiri also noted. I've also updated the
'tty-splice' branch if you prefer them that way.

And I *should* say that I still haven't tested _any_ of the HDLC
changes. I have no idea how to do that, and if somebody can point to a
test-case (or better yet, actually has a real life situation where
they use it and can test this all) it would be great.

Jiri, any other issues, or any comment of yours I missed? I didn't do
the min() thing, I find the explicit conditional more legible myself,
but won't complain if somebody else then disagrees and wants to clean
it up.

(On the matter of cleanups: when reading through the ICANON handling
in canon_copy_from_read_buf(), that code is really completely
incomprehensible. I know how it works, and why it does it, but I had
to remind myself, because the code just looks crazy and does things
like "*nr+1" to walk _past_ the point we actually copy etc. I was very
tempted to rewrite that entirely, but wanting to keep my changes
minimal and targeted made me not do so).

                Linus

--000000000000822f5305b96d6e07
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-tty-fix-up-hung_up_tty_write-conversion.patch"
Content-Disposition: attachment; 
	filename="0001-tty-fix-up-hung_up_tty_write-conversion.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kk773s0z0>
X-Attachment-Id: f_kk773s0z0

RnJvbSBiZjZlZTg1OGZkZmYyYTE4MDBmZDE5OGJiZTkwMDM0ZGNkNjBmM2VmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjEgSmFuIDIwMjEgMTA6MDQ6MjcgLTA4MDAKU3ViamVjdDog
W1BBVENIIDEvM10gdHR5OiBmaXggdXAgaHVuZ191cF90dHlfd3JpdGUoKSBjb252ZXJzaW9uCgpJ
biBjb21taXQgInR0eTogaW1wbGVtZW50IHdyaXRlX2l0ZXIiLCBJIGxlZnQgdGhlIHdyaXRlX2l0
ZXIgY29udmVyc2lvbgpvZiB0aGUgaHVuZyB1cCB0dHkgY2FzZSBhbG9uZSwgYmVjYXVzZSBJIGlu
Y29ycmVjdGx5IHRob3VnaHQgaXQgZGlkbid0Cm1hdHRlci4KCkppcmkgc2hvd2VkIG1lIHRoZSBl
cnJvcnMgb2YgbXkgd2F5cywgYW5kIHBvaW50ZWQgb3V0IHRoZSBwcm9ibGVtcyB3aXRoCnRoYXQg
aW5jb21wbGV0ZSBjb252ZXJzaW9uLiAgRml4IGl0IGFsbCB1cC4KClJlcG9ydGVkLWJ5OiBKaXJp
IFNsYWJ5IDxqaXJpc2xhYnlAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFs
ZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGRyaXZlcnMvdHR5L3R0eV9p
by5jIHwgOSArKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvdHR5X2lvLmMgYi9kcml2ZXJzL3R0
eS90dHlfaW8uYwppbmRleCA4ODQ2ZDNiOTk4NDUuLjUyNDg5ZjhiNzQwMSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90dHkvdHR5X2lvLmMKKysrIGIvZHJpdmVycy90dHkvdHR5X2lvLmMKQEAgLTQzNyw4
ICs0MzcsNyBAQCBzdGF0aWMgc3NpemVfdCBodW5nX3VwX3R0eV9yZWFkKHN0cnVjdCBmaWxlICpm
aWxlLCBjaGFyIF9fdXNlciAqYnVmLAogCXJldHVybiAwOwogfQogCi1zdGF0aWMgc3NpemVfdCBo
dW5nX3VwX3R0eV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmJ1
ZiwKLQkJCQkgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpCitzdGF0aWMgc3NpemVfdCBodW5n
X3VwX3R0eV93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJvbSkK
IHsKIAlyZXR1cm4gLUVJTzsKIH0KQEAgLTUwNiw3ICs1MDUsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGZpbGVfb3BlcmF0aW9ucyBjb25zb2xlX2ZvcHMgPSB7CiBzdGF0aWMgY29uc3Qgc3RydWN0
IGZpbGVfb3BlcmF0aW9ucyBodW5nX3VwX3R0eV9mb3BzID0gewogCS5sbHNlZWsJCT0gbm9fbGxz
ZWVrLAogCS5yZWFkCQk9IGh1bmdfdXBfdHR5X3JlYWQsCi0JLndyaXRlCQk9IGh1bmdfdXBfdHR5
X3dyaXRlLAorCS53cml0ZV9pdGVyCT0gaHVuZ191cF90dHlfd3JpdGUsCiAJLnBvbGwJCT0gaHVu
Z191cF90dHlfcG9sbCwKIAkudW5sb2NrZWRfaW9jdGwJPSBodW5nX3VwX3R0eV9pb2N0bCwKIAku
Y29tcGF0X2lvY3RsCT0gaHVuZ191cF90dHlfY29tcGF0X2lvY3RsLApAQCAtMTEwMyw3ICsxMTAy
LDkgQEAgc3RhdGljIHNzaXplX3QgdHR5X3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0
IGlvdl9pdGVyICpmcm9tKQogCWlmICh0dHktPm9wcy0+d3JpdGVfcm9vbSA9PSBOVUxMKQogCQl0
dHlfZXJyKHR0eSwgIm1pc3Npbmcgd3JpdGVfcm9vbSBtZXRob2RcbiIpOwogCWxkID0gdHR5X2xk
aXNjX3JlZl93YWl0KHR0eSk7Ci0JaWYgKCFsZCB8fCAhbGQtPm9wcy0+d3JpdGUpCisJaWYgKCFs
ZCkKKwkJcmV0dXJuIGh1bmdfdXBfdHR5X3dyaXRlKGlvY2IsIGZyb20pOworCWlmICghbGQtPm9w
cy0+d3JpdGUpCiAJCXJldCA9IC1FSU87CiAJZWxzZQogCQlyZXQgPSBkb190dHlfd3JpdGUobGQt
Pm9wcy0+d3JpdGUsIHR0eSwgZmlsZSwgZnJvbSk7Ci0tIAoyLjI5LjIuMTU3LmcxZDQ3NzkxYTM5
Cgo=
--000000000000822f5305b96d6e07
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-tty-fix-up-hung_up_tty_read-conversion.patch"
Content-Disposition: attachment; 
	filename="0002-tty-fix-up-hung_up_tty_read-conversion.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kk773vey1>
X-Attachment-Id: f_kk773vey1

RnJvbSAxNDQzYjkyYTFmZjNhMGFmNWYwZTVhMTc3ZGIyZDg0MzI3M2EyY2ExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjEgSmFuIDIwMjEgMTA6MDg6MTUgLTA4MDAKU3ViamVjdDog
W1BBVENIIDIvM10gdHR5OiBmaXggdXAgaHVuZ191cF90dHlfcmVhZCgpIGNvbnZlcnNpb24KCklu
IGNvbW1pdCAidHR5OiBpbXBsZW1lbnQgcmVhZF9pdGVyIiwgSSBsZWZ0IHRoZSByZWFkX2l0ZXIg
Y29udmVyc2lvbiBvZgp0aGUgaHVuZyB1cCB0dHkgY2FzZSBhbG9uZSwgYmVjYXVzZSBJIGluY29y
cmVjdGx5IHRob3VnaHQgaXQgZGlkbid0Cm1hdHRlci4KCkppcmkgc2hvd2VkIG1lIHRoZSBlcnJv
cnMgb2YgbXkgd2F5cywgYW5kIHBvaW50ZWQgb3V0IHRoZSBwcm9ibGVtcyB3aXRoCnRoYXQgaW5j
b21wbGV0ZSBjb252ZXJzaW9uLiAgRml4IGl0IGFsbCB1cC4KClJlcG9ydGVkLWJ5OiBKaXJpIFNs
YWJ5IDxqaXJpc2xhYnlAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogTGludXMgVG9ydmFsZHMg
PHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgotLS0KIGRyaXZlcnMvdHR5L3R0eV9pby5j
IHwgOSArKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvdHR5X2lvLmMgYi9kcml2ZXJzL3R0eS90
dHlfaW8uYwppbmRleCA1MjQ4OWY4Yjc0MDEuLmQ3ODgzZGE3YmEzZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvdHR5X2lvLmMKKysrIGIvZHJpdmVycy90dHkvdHR5X2lvLmMKQEAgLTQzMSw4ICs0
MzEsNyBAQCBzdHJ1Y3QgdHR5X2RyaXZlciAqdHR5X2ZpbmRfcG9sbGluZ19kcml2ZXIoY2hhciAq
bmFtZSwgaW50ICpsaW5lKQogRVhQT1JUX1NZTUJPTF9HUEwodHR5X2ZpbmRfcG9sbGluZ19kcml2
ZXIpOwogI2VuZGlmCiAKLXN0YXRpYyBzc2l6ZV90IGh1bmdfdXBfdHR5X3JlYWQoc3RydWN0IGZp
bGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsCi0JCQkJc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBw
b3MpCitzdGF0aWMgc3NpemVfdCBodW5nX3VwX3R0eV9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwg
c3RydWN0IGlvdl9pdGVyICp0bykKIHsKIAlyZXR1cm4gMDsKIH0KQEAgLTUwNCw3ICs1MDMsNyBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBjb25zb2xlX2ZvcHMgPSB7CiAK
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGh1bmdfdXBfdHR5X2ZvcHMgPSB7
CiAJLmxsc2VlawkJPSBub19sbHNlZWssCi0JLnJlYWQJCT0gaHVuZ191cF90dHlfcmVhZCwKKwku
cmVhZF9pdGVyCT0gaHVuZ191cF90dHlfcmVhZCwKIAkud3JpdGVfaXRlcgk9IGh1bmdfdXBfdHR5
X3dyaXRlLAogCS5wb2xsCQk9IGh1bmdfdXBfdHR5X3BvbGwsCiAJLnVubG9ja2VkX2lvY3RsCT0g
aHVuZ191cF90dHlfaW9jdGwsCkBAIC05MjQsOCArOTIzLDEwIEBAIHN0YXRpYyBzc2l6ZV90IHR0
eV9yZWFkKHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAkvKiBXZSB3
YW50IHRvIHdhaXQgZm9yIHRoZSBsaW5lIGRpc2NpcGxpbmUgdG8gc29ydCBvdXQgaW4gdGhpcwog
CSAgIHNpdHVhdGlvbiAqLwogCWxkID0gdHR5X2xkaXNjX3JlZl93YWl0KHR0eSk7CisJaWYgKCFs
ZCkKKwkJcmV0dXJuIGh1bmdfdXBfdHR5X3JlYWQoaW9jYiwgdG8pOwogCWkgPSAtRUlPOwotCWlm
IChsZCAmJiBsZC0+b3BzLT5yZWFkKQorCWlmIChsZC0+b3BzLT5yZWFkKQogCQlpID0gaXRlcmF0
ZV90dHlfcmVhZChsZCwgdHR5LCBmaWxlLCB0byk7CiAJdHR5X2xkaXNjX2RlcmVmKGxkKTsKIAot
LSAKMi4yOS4yLjE1Ny5nMWQ0Nzc5MWEzOQoK
--000000000000822f5305b96d6e07
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-tty-fix-up-iterate_tty_read-EOVERFLOW-handling.patch"
Content-Disposition: attachment; 
	filename="0003-tty-fix-up-iterate_tty_read-EOVERFLOW-handling.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kk773y152>
X-Attachment-Id: f_kk773y152

RnJvbSAyYjNkYThjZjdlY2FmZTQ4NzA0ZjYyMDQ2ZmNlNWRhNWQxN2I5ZTZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjEgSmFuIDIwMjEgMTA6MTc6MjUgLTA4MDAKU3ViamVjdDog
W1BBVENIIDMvM10gdHR5OiBmaXggdXAgaXRlcmF0ZV90dHlfcmVhZCgpIEVPVkVSRkxPVyBoYW5k
bGluZwoKV2hlbiBJIGNvbnZlcnRlZCB0aGUgdHR5X2xkaXNjX29wcyAncmVhZCgpJyBmdW5jdGlv
biB0byB0YWtlIGEga2VybmVsCnBvaW50ZXIsIEkgd2FzIGEgYml0IHRvbyBhZ2dyZXNzaXZlIGFi
b3V0IHRoZSBsZGlzYyByZXR1cm5pbmcgRU9WRVJGTE9XLgoKWWVzLCB3ZSB3YW50IHRvIGhhdmUg
RU9WRVJGTE9XIG92ZXJyaWRlIGFueSBwYXJ0aWFsbHkgcmVhZCBkYXRhIChiZWNhdXNlCnRoZSB3
aG9sZSBwb2ludCBpcyB0aGF0IHRoZSBidWZmZXIgd2FzIHRvbyBzbWFsbCBmb3IgdGhlIHdob2xl
IHBhY2tldCwKYW5kIHdlIGRvbid0IHdhbnQgdG8gc2VlIHBhcnRpYWwgcGFja2V0cyksIGJ1dCBp
dCBzaG91bGRuJ3Qgb3ZlcnJpZGUgYQpwcmV2aW91cyBFRkFVTFQuCgpBbmQgaW4gZmFjdCwgaXQg
cmVhbGx5IGlzIGp1c3QgRU9WRVJGTE9XIHRoYXQgaXMgc3BlY2lhbCBhbmQgc2hvdWxkCnRocm93
IGF3YXkgYW55IHBhcnRpYWxseSByZWFkIGRhdGEsIG5vdCAiYW55IGVycm9yIi4gIEFkbWl0dGVk
bHkKRU9WRVJGTE9XIGlzIGN1cnJlbnRseSB0aGUgb25seSBvbmUgdGhhdCBjYW4gaGFwcGVuIGZv
ciBhIGNvbnRpbnVhdGlvbgpyZWFkIC0gYW5kIGlmIHRoZSBmaXJzdCByZWFkIGl0ZXJhdGlvbiBy
ZXR1cm5zIGFuIGVycm9yIHdlIHdvbid0IGhhdmUgdGhpcyBpc3N1ZS4KClNvIHRoaXMgaXMgbW9y
ZSBvZiBhIHRlY2huaWNhbGl0eSwgYnV0IGxldCdzIGp1c3QgbWFrZSB0aGUgaW50ZW50IHZlcnkK
ZXhwbGljaXQsIGFuZCByZS1vcmdhbml6ZSB0aGUgZXJyb3IgaGFuZGxpbmcgYSBiaXQgc28gdGhh
dCB0aGlzIGlzIGFsbApjbGVhcmVyLgoKUmVwb3J0ZWQtYnk6IEppcmkgU2xhYnkgPGppcmlzbGFi
eUBrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGlu
dXgtZm91bmRhdGlvbi5vcmc+Ci0tLQogZHJpdmVycy90dHkvdHR5X2lvLmMgfCAxOSArKysrKysr
KysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS90dHlfaW8uYyBiL2RyaXZlcnMvdHR5L3R0
eV9pby5jCmluZGV4IGQ3ODgzZGE3YmEzZC4uODhiNGM0OTYzNDYxIDEwMDY0NAotLS0gYS9kcml2
ZXJzL3R0eS90dHlfaW8uYworKysgYi9kcml2ZXJzL3R0eS90dHlfaW8uYwpAQCAtODYxLDEzICs4
NjEsMjAgQEAgc3RhdGljIGludCBpdGVyYXRlX3R0eV9yZWFkKHN0cnVjdCB0dHlfbGRpc2MgKmxk
LCBzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LAogCQlpZiAoIXNpemUpCiAJCQlicmVhazsKIAotCQkv
KgotCQkgKiBBIGxkaXNjIHJlYWQgZXJyb3IgcmV0dXJuIHdpbGwgb3ZlcnJpZGUgYW55IHByZXZp
b3VzbHkgY29waWVkCi0JCSAqIGRhdGEgKGVnIC1FT1ZFUkZMT1cgZnJvbSBIRExDKQotCQkgKi8K
IAkJaWYgKHNpemUgPCAwKSB7Ci0JCQltZW16ZXJvX2V4cGxpY2l0KGtlcm5lbF9idWYsIHNpemVv
ZihrZXJuZWxfYnVmKSk7Ci0JCQlyZXR1cm4gc2l6ZTsKKwkJCS8qIERpZCB3ZSBoYXZlIGFuIGVh
cmxpZXIgZXJyb3IgKGllIC1FRkFVTFQpPyAqLworCQkJaWYgKHJldHZhbCkKKwkJCQlicmVhazsK
KwkJCXJldHZhbCA9IHNpemU7CisKKwkJCS8qCisJCQkgKiAtRU9WRVJGTE9XIG1lYW5zIHdlIGRp
ZG4ndCBoYXZlIGVub3VnaCBzcGFjZQorCQkJICogZm9yIGEgd2hvbGUgcGFja2V0LCBhbmQgd2Ug
c2hvdWxkbid0IHJldHVybgorCQkJICogYSBwYXJ0aWFsIHJlc3VsdC4KKwkJCSAqLworCQkJaWYg
KHJldHZhbCA9PSAtRU9WRVJGTE9XKQorCQkJCW9mZnNldCA9IDA7CisJCQlicmVhazsKIAkJfQog
CiAJCWNvcGllZCA9IGNvcHlfdG9faXRlcihrZXJuZWxfYnVmLCBzaXplLCB0byk7Ci0tIAoyLjI5
LjIuMTU3LmcxZDQ3NzkxYTM5Cgo=
--000000000000822f5305b96d6e07--
