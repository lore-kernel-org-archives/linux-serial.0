From: Romano Giannetti <romanol@upco.es>
Subject: multiple console= kernel line bug (or misdocumentation)?
Date: Fri, 1 Apr 2005 17:19:45 +0200
Message-ID: <20050401151945.GB21157@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from upco.es ([130.206.70.227]:20864 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262765AbVDAPTs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 1 Apr 2005 10:19:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail1.upco.es (Postfix) with ESMTP id 9FDFE4410B
	for <linux-serial@vger.kernel.org>; Fri,  1 Apr 2005 17:19:47 +0200 (CEST)
Received: from mail1.upco.es ([127.0.0.1])
	by localhost (mail1 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 08516-08 for <linux-serial@vger.kernel.org>;
	Fri, 1 Apr 2005 17:19:46 +0200 (CEST)
Received: from pern.dea.icai.upco.es (pern.dea.icai.upco.es [130.206.71.186])
	by mail1.upco.es (Postfix) with ESMTP id 1B1AF45056
	for <linux-serial@vger.kernel.org>; Fri,  1 Apr 2005 17:19:46 +0200 (CEST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

   good afternoon to all. I have a question that probably is just due to my
   ignorance, but I hope you will be nice with me...

   I am trying to debug S3 suspend, so I compiled the serial console in. I
   noticed a strange thing. If I boot with

           console=ttyS0,115200n8 console=tty0 

   I have *most* messages echoed to the serial line, but for example magic
   sysrq-t and sysrq-t simply put "SysRq : Show Memory" on both and the
   dumps goes just to tty0. 
   
   If, on the other hand, I boot with just 

           console=ttyS0,115200n8

   all messages goes to the serial console. Is this expected/normal
   behaviour? If yes, I think it should be added to
   Documentation/serial-console.txt...

   TIA, 
           Romano   

   
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
