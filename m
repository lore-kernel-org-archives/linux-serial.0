Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096A25F99F;
	Mon, 12 Oct 2026 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770335; cv=none; b=jDDkpI5248DWJLwAuNo+3JsjtKmj59T7jUSQ5rx8QX6zoyN2wIhRb93cxGBPU9e5IzVYMY2l+uBgF59e5lg4oRP0jEFKuPT6gX2faRa1QcjjrFs5d2q9TOuQHChuu8mlPsn3gHQ8yj7Q36OThAUGNxdYMOFNQ+a/SfHfaZTJGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770335; c=relaxed/simple;
	bh=m/WK/MyD22PzCKpazs4O7b+IE6Lv4Bm9Vny3DgkQtcE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=F9hOacQv8PLd7yZyzMQmZ7SlUQgw852dTjTg9Kg9p8eJ4Dn5gKie3yMQGtPtQkao89YQ623BtIL/NcpZ2lxA9DtxS13+okSy/tSM1vGFZVKX2SHmfW9gp6eTSMRr40NOAR+i/dF0KBeXkFPH91r9e6lFNKRJQnJcpe+e5wSPNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 9D7FD92009C; Mon, 12 Oct 2026 03:49:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 9267392009B;
	Mon, 12 Oct 2026 02:49:48 +0100 (BST)
Date: Mon, 12 Oct 2026 02:49:48 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, Kees Cook <kees@kernel.org>, 
    Lukas Wunner <lukas@wunner.de>, John Ogness <john.ogness@linutronix.de>, 
    Jiayuan Chen <jiayuan.chen@shopee.com>, Gerhard Engleder <eg@keba.com>, 
    linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] serial: core: Don't clobber the baud rate on hangup
 via B0
Message-ID: <alpine.DEB.2.21.2610120150230.55767@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-2058476832-1387339034-1791767440=:55767"
Content-ID: <alpine.DEB.2.21.2610120211240.55767@angie.orcam.me.uk>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---2058476832-1387339034-1791767440=:55767
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <alpine.DEB.2.21.2610120211241.55767@angie.orcam.me.uk>

Greg,

 As we discussed at LPC, this is an update to the fix previously posted as 
an RFC.  I have verified it with the system originally affected, running 
the console at 115200bps; see the attached console output logs for the bad 
vs fixed case.  All that needed to be done to reproduce it was to keep 
killing getty(8)s repeatedly until init(8) decided something was wrong and 
chose to put their inittab(5) entries into a snooze, leaving the line(s) 
at the wrong speed setting.

 NB this fixes the missing %B0 literal markup as a part of the doc update.  
I've concluded it's not worth splitting off into a separate patch.  Let me 
know if you think otherwise.

 Previous iteration (v1) at
<https://lore.kernel.org/r/alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk/>.

  Maciej
---2058476832-1387339034-1791767440=:55767
Content-Type: text/plain; CHARSET=US-ASCII; NAME=swarm-bad.log
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2610120210400.55767@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=swarm-bad.log

G1tIG1tKDXN3YXJtLm9yY2FtLm1lLnVrIGxvZ2luOiAA/gD+AAAAAAAA/gAA
8AAA8AD+AADwAADwAP4A/gAA8AAA8AD+AAAAwAD+AP4A/gAA8AD+AADwAAAA
AAAAAPgAAPAA/gAA8AAA8AD+AAAAwAAA8AD+AAAAAAAAAPgAAPAAAPAAAADA
AADwAP4AAPAA/gD+AAAAAAAA/gAA8AAA8AAAAMAAAPAAAAAAAAAA+AAA8AAA
8AAA8AD+AP4A/gAA8AD+AP4AAPAA/gAAAAAAAP4A/gD+AAAAAAAA/gD+AP4A
/gAA8AD+AP4A/gAA8AD+AP4AAPAA/gD+AP4AAPAA/gAAAAAAAADwAADwAAAA
wAD+AP4A/gD+AP4A/gD+AP4AAAAAAAAA8AAA8AAA8AAA8AD+AP4AAAAAAAD+
AP4AAPAA/gAAAMAA/gD+AADwAP4AAPAAAAAAAAAA8AAA8AAAAMAAAPAA/gD+
AADwAP4A/gD+AADwAP4A/gAAAAAAAP4AAPAAAADAAP4AAADAAP4A/gD+AP4A
APAA/gAAAMAAAPAA/gAAAAAAAAD4AADwAADwAADwAP4A/gD+AP4AAPAAAPAA
/gAAAAAAAAD4AADwAP4A/gD+AADwAAAAAAAAAPgAAPAA/gD+AP4A/gD+AADw
AP4A/gAA8AD+AP4A/gD+AP4A/gAAAMAA/gD+AP4A/gAA8AD+AP4AAPAA/gD+
AP4AAAAAAAAA8AD+AAAAAAAA/gD+AAAAAAAA/gAA8AAA8AD+AADwAADwAP4A
/gAA8AAA8AD+AAAAwAD+AP4A/gAA8AD+AADwAAAAAAAAAPgAAPAA/gAA8AAA
8AD+AAAAwAAA8AD+AAAAAAAAAPAAAPAAAPAAAADAAADwAP4AAPAA/gD+AP4A
AADAAADwAADwAAAAwAAA8AAAAAAAAADwAADwAADwAADwAP4A/gD+AADwAP4A
/gAA8AD+AAAAAAAA/gD+AP4AAAAAAAD+AP4A/gD+AADwAP4A/gD+AADwAP4A
/gAA8AD+AP4A/gAA8AD+AAAAAAAAAPgAAPAAAADAAP4A/gD+AP4A/gD+AP4A
/gAAAAAAAAD4AADwAADwAADwAP4A/gAAAAAAAP4A/gAA8AD+AAAAwAD+AP4A
APAA/gAA8AAAAAAAAAD4AADwAAAAwAAA8AD+AP4AAPAA/gD+AP4AAPAA/gD+
AAAAAAAA/gAA8AAAAMAA/gAAAMAA/gD+AP4A/gAA8AD+AAAAwAAA8AD+AAAA
AAAAAPAAAPAAAPAAAPAA/gD+AP4A/gAA8AAA8AD+AAAAAAAAAPAAAPAA/gD+
AP4AAPAAAAAAAAAA+AAA8AD+AP4A/gD+AP4AAPAA/gD+AADwAP4A/gD+AP4A
/gD+AAAAwAD+AP4A/gD+AADwAP4A/gAA8AD+AP4A/gAAAAAAAADwAP4AAAAA
AAD+AP4AAAAAAAD+AADwAADwAP4AAPAAAPAA/gD+AADwAADwAP4AAADAAP4A
/gD+AADwAP4AAPAAAAAAAAAA8AAA8AAA8AD+AP4A/gD+AP4AAAAAAAAA+AAA
8AD+AP4A/gD+AP4A/gD+AADwAADwAP4A/gD+AADwAP4AAAAAAAAA+AAA8AAA
AAAAAP4A/gAA8AAA8AD+AP4A/gD+AP4AAADAAP4A/gD+AADwAP4A/gAA8AD+
AP4AAPAA/gD+AP4AAPAA/gD+AADwAP4AAAAAAAAA+AAA8AAAAMAA/gD+AP4A
/gAA8AD+AADwAADwAP4AAADAAP4A/gAAAAAAAADwAADwAP4AAPAA/gD+AADw
AP4A/gAAAAAAAADwAADwAAAAwAD+AP4AAAAAAAD+AP4A/gAA8AD+AP4A/gAA
8AD+AAAAAAAAAPgAAPAAAPAAAPAA/gD+AP4A/gD+AADwAP4A/gAAAMAA/gD+
AP4A/gAA8AD+AADwAP4A/gD+AP4AAPAA/gAAAMAA/gD+AP4A/gAAAAAAAADw
AP4AAAAAABtbSBtbSg1zd2FybS5vcmNhbS5tZS51ayBsb2dpbjogDQo=

---2058476832-1387339034-1791767440=:55767
Content-Type: text/plain; CHARSET=US-ASCII; NAME=swarm-fixed.log
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.21.2610120210401.55767@angie.orcam.me.uk>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME=swarm-fixed.log

G1tIG1tKc3dhcm0ub3JjYW0ubWUudWsgbG9naW46IElOSVQ6IElkICJTMCIg
cmVzcGF3bmluZyB0b28gZmFzdDogZGlzYWJsZWQgZm9yIDUgbWludXRlcw0K
SU5JVDogSWQgIlMxIiByZXNwYXduaW5nIHRvbyBmYXN0OiBkaXNhYmxlZCBm
b3IgNSBtaW51dGVzDQpJTklUOiBubyBtb3JlIHByb2Nlc3NlcyBsZWZ0IGlu
IHRoaXMgcnVubGV2ZWwNChtbSBtbSnN3YXJtLm9yY2FtLm1lLnVrIGxvZ2lu
OiANCg==

---2058476832-1387339034-1791767440=:55767--
